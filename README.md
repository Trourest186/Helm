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
- _(updating new chart here...)

## Useful Commands

```
# Create target for working
$ helm create "target"

# Check template file
$ helm lint "dic path"

# Check full template
$ helm template "Release parameters" "dic path" -f "values file"

# Install helm packet
- Using charts web
- Using local
$ helm install "chart name" "dic path"

# Updating chart
$ helm upgrade "chart name" "dic path" -f "values file"

# Packing for pushing repository
$ mkdir "folder contains"
$ helm package "dic path" -d "contained path"
$ helm repo index "dic path" (created in contain path)

```
