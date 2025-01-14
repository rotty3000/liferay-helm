# liferay-helm

A Helm Chart for Liferay DXP

## Install the Chart

### For Local Development

Required dependencies:

- Kubectl (recommend `brew install kubernetes-cli`)
- Helm (recommend `brew install helm`)
- K3d (recommend `brew install k3d`)
- Stern (recommend `brew install stern`)

#### Setup a local Kubernetes cluster

The simplest and most comprehensive approach is to use K3d because it supports built-in ingress and seamlessly integrates with Docker's hostname resolution for addresses with the suffix `*.docker.localhost`. (not tested on MacOS or Windows yet)

```shell
k3d cluster create playground \
  -p "80:80@loadbalancer" \
  -p "443:443@loadbalancer" \
```

#### Install the Chart

It is recommended to install the chart into a custom namespace.

```shell
helm upgrade -i liferay-helm -n liferay-system --create-namespace .
```

By default the chart will use the `liferay/dxp:latest` docker image.

#### Check the Installation Progress

There are many moving parts (including downloading the Liferay DXP image) and so it will take several seconds (up to several minutes) before the system is fully working.

I recommend using the following command (which you can run immediately after the helm command completes):

```shell
sterm -n liferay-system liferay-helm-0
```

This will log all the output of Liferay DXP (including waiting for it to start).

#### How to Gain Access

There are 3 preset addresses:

- DXP: http://main.dxp.docker.localhost

  The default user name and password are `test@main.dxp.docker.localhost` : `test`.

- MinIO (S3 Server):

  - Console: http://console.minio.docker.localhost
  - API: http://console.minio.docker.localhost

  The default user name and password are `minio` : `miniominio`.

#### Specify a version of Liferay DXP

To specify the version of Liferay DXP to deploy supply a value for `image.tag` on the command line

```shell
helm upgrade -i liferay-helm -n liferay-system --create-namespace \
	--set image.tag=2024.q3.13 \
	.
```

### Additional Virtual Hosts

If you create additional virtual instances in DXP select a hostname deriving from `*.dxp.docker.localhost` and specify that value for each of **WebId**, **Virtual Host** and **Mail Domain**. Once the Virtual Instance is created that host should be reachable without further action.

e.g. create a new host using:

- **WebId**: `two.dxp.docker.localhost`
- **Virtual Host**: `two.dxp.docker.localhost`
- **Mail Domain**: `two.dxp.docker.localhost`
- Wait for completion then access the virtual instance at http://two.dxp.docker.localhost

## Uninstallation

If all you want to do is update the chart, simply execute the install instruction above.

However, to uninstall the chart simply do:

```shell
helm uninstall -n liferay-system liferay-helm
```

To also remove all the persistent volume claims (which destroys all the data) simply do:

```shell
k delete -n liferay-system persistentvolumeclaims \
  liferay-elasticsearch-pvc-liferay-helm-elasticsearch-0 \
  liferay-minio-pvc-liferay-helm-minio-0 \
  liferay-postgres-pvc-liferay-helm-postgres-0 \
  liferay-working-data-pvc-liferay-helm-0
```

## Basic Observation of the Chart

If you want to watch the progress of the chart the following simple command works well:

```shell
watch -n .5 kubectl get -n liferay-system all,svc,cm,pvc,ingress
```
