# liferay-helm

A Helm Chart for Liferay DXP

## Install the Chart

### For Local Development

#### Setup a local Kubernetes cluster

The simplest and most comprehensive approach is to use K3d because it easily supports ingress and seamlessly integrates with hostname resolution provided by Docker's support for `*.docker.localhost` addresses. (Liferay will be found at `main.dxp.docker.localhost`.)

```shell
k3d cluster create playground \
  -p "80:80@loadbalancer" \
  -p "443:443@loadbalancer" \
  --registry-create registry:0.0.0.0:5000
```

#### Install the Chart for Local Development

It is recommended to install the entire chart into a custom namespace.

```shell
helm upgrade -i liferay-helm \
	-n liferay-system \
	--create-namespace \
	.
```

By default the chart will deploy `liferay/dxp:latest`.

#### Specify a version of Liferay DXP

By supplying the value of `image.tag` we can select the specific version of Liferay DXP to deploy.

```shell
helm upgrade -i liferay-helm \
	-n liferay-system \
	--create-namespace \
	--set image.tag=2024.q3.13 \
	.
```
