# Helm Charts

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
