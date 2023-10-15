# hello-world-k8s-mysql-nodejs
Get Hellow World response to HTTP request. Nodejs application fetches the data from MySQL database and serve as HTTP response.

# Repository Structure
Following is the repository structure -
```
.
├── docker
│   └── node_project
├── helm
│   ├── mysql
│   └── nodejs
├── k8s
├── LICENSE
├── README.md
└── setup.sh
```
- **docker/node_project** -
Contains Dockerfile and nodejs project supporting code
- **helm/mysql** -
Contains MySLQ helm chart
- **helm/nodejs** -
Contains nodejs helm chart
- **k8s** -
Contains kubernets supporting code e.g configmap, secretes, namespaces.
- **LICENSE** -
GPLv3.0 license file.
- **README.md** -
README contains explaination about the repository
- **setup.sh** -
Deployment script to roll resources to the cluster

# Prerequisite
- Following tools required to be installed and running/available -

| Tool Name  | Tested on Version |
| ------------- | ------------- |
| Minikube  | v1.25.2  |
|  Kubectl  |  v1.23.5 |
| Docker  | 20.10.13 |
| Helm  | v3.8.1 |
| Bash  | 5.0.17(1)-release |
| Sed  | (GNU sed) 4.7 |
| Docker  | 20.10.13 |


- Namespaces dev and prod should not be present in kubernetes (these namespaces will be created as part of setup)
- Internet access

# How to run
Use following steps in each scenario
1. To setup Dev Environment
     - Clone this repository
     - Run script setup.sh from root of the repository.
     - User input is needed to setup the MySQL User password -
        
        `bash ./setup.sh setup_env dev`
     - Sample expected Output. Open the actual shown URL on your terminal into the web-browser

        `2022-03-28-19-16: Open URL http://192.168.49.2:32443`
2. To setup Prod Environment
     - Clone this repository
     - Run script setup.sh from root of the repository.
     - User input is needed to setup the MySQL User password -

        `bash ./setup.sh setup_env prod`
     - Sample expected Output. Open the actual shown URL on your terminal into the web-browser

        `2022-03-28-19-20: Open URL http://192.168.49.2:31735`
3. To cleanup created resources
     - Clone this repository
     - Run script setup.sh from root of the repository
     - It delete all resources including dev,prod namespace etc.
     - User input is needed for confirmation -
        
        `bash ./setup.sh cleanup_all`
