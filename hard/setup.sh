#!/bin/bash
set -e
log()
{
 echo "`date +"%Y-%m-%d-%H-%M"`: $1"
}

root_dir=$(pwd)

log "Starting the script"

build_docker(){
    #Build nodejs docker image
    eval $(minikube docker-env)
    cd "$root_dir/docker/node_project"
    docker build -t nodejs-hello-world .
}

setup_namespaces(){
    #Create a namespace
    cd "$root_dir/k8s"
    set +e
    kubectl create -f "$1-namespace.yml"
    set -e
}

create_config_secrete(){
    #Create configmap and secrets
    cd "$root_dir/k8s"
    read -p "Enter password for mysql root user (defalut password): " MYSQL_PASSWORD
    MYSQL_PASSWORD=${MYSQL_PASSWORD:-password}
    BASE64_MYSQL_PASSWORD=$(echo -n $MYSQL_PASSWORD | base64)
    sed -i "s|    MYSQL_PASSWORD: .*|    MYSQL_PASSWORD: $BASE64_MYSQL_PASSWORD|" secret.yml
    sed -i "s|  MYSQL_HOST: .*|  MYSQL_HOST: mysql-helm-0.mysql-helm.$1.svc.cluster.local|g" configmap.yml
    kubectl config set-context --current --namespace=$1
    kubectl apply -f secret.yml
    kubectl apply -f configmap.yml
}

install_helm(){
    #Install mysql and nodejs helm chart
    cd "$root_dir/helm"
    kubectl config set-context --current --namespace=$1
    helm install mysql-helm mysql
    log "Waiting for mysql setup to be done"
    sleep 60
    helm install nodejs-helm nodejs --set service.nodePort=$(shuf -i 30000-32768 -n 1)
    log "Waiting for nodejs setup to be done"
    sleep 10
}

cleanup_all(){
    #Delete all namespaces
    read -p "Cleanup all (Including dev,prod namespace etc)(y/n): " y_or_n
    if [[ "$y_or_n" == "y" ]]; then
        set +e
        kubectl delete namespace dev
        kubectl delete namespace prod
        set -e
    fi
}

get_node_ip_port(){
    #Get node ip and node port
    export NODE_PORT=$(kubectl get --namespace $1 -o jsonpath="{.spec.ports[0].nodePort}" services nodejs-helm)
    export NODE_IP=$(kubectl get nodes --namespace $1 -o jsonpath="{.items[0].status.addresses[0].address}")
    log "Open URL http://$NODE_IP:$NODE_PORT"
}

case $1 in
    setup_env)
        if [[ "$2" == "dev" || "$2" == "prod" ]]; then
            build_docker
            setup_namespaces $2
            create_config_secrete $2
            install_helm $2
            get_node_ip_port $2
        else
            log "Use: bash ./setup.sh setup_env [dev|prod]"
        fi
    ;;
    cleanup_all)
        cleanup_all
    ;;
    *)
        echo -n "Use: bash ./setup.sh [setup_env [dev|prod] | cleanup_all]"
    ;;
esac
