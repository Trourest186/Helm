# Helm Charts from nhtua
Hi, I'm a DevOps engineer. I created this repository to keep my K8s recipes. It basically serves for many tutorials I made on [my Youtube channel](https://www.youtube.com/channel/UC64HFdJWvwuNt2ruywWvF-w).

But you're free to use and contribute all Helm charts here. 

## Usage

Some common Helm commands for you

```
# Add repo before using
$ helm repo add nhtua https://raw.githubusercontent.com/nhtua/charts/master/
"nhtua" has been added to your repositories

# Search for charts, or list all the charts by repo's name
$ helm search repo nhtua
NAME                	CHART VERSION	APP VERSION	DESCRIPTION
nhtua/ambassador-ssl	0.1.0        	1.0.0      	A Helm chart for Kubernetes

# Get configurations (values file)
$ helm show values nhtua/ambassador-ssl > myvalues.yaml

# Install chart with your configurations
$ helm install mywebsite-ssl nhtua/ambassador-ssl
```

## List of charts

- Ambassador-SSL : install Let's Encrypt certificate for your Ambassador API Gateway (Ambassaador Edge Stack)
- _(updating new chart here...)_
