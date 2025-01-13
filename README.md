# liferay-helm

A Helm Chart for Liferay DXP

## Install the Chart

### For Local Development

#### Setup a local Kubernetes cluster

The simplest and most comprehensive approach is to use K3d because it easily supports ingress and seamlessly integrates with hostname resolution provided by Docker's support for `*.docker.localhost` addresses.

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

#### Specify a version of Liferay DXP

To specify the version of Liferay DXP to deploy supply a value for `image.tag` on the command line

```shell
helm upgrade -i liferay-helm -n liferay-system --create-namespace \
	--set image.tag=2024.q3.13 \
	.
```

### How to Gain Access

There are 3 preset addresses:

- DXP: http://main.dxp.docker.localhost

  The default user name and password are `testhelm` : `testhelm`.
- MinIO (S3 Server):
  - Console: http://console.minio.docker.localhost
  - API: http://console.minio.docker.localhost

  The default user name and password are `minio` : `miniominio`.

### Additional Virtual Hosts

If you create additional virtual instances select a derivative of `*.dxp.docker.localhost` and specify that value for each of **WebId**, **Virtual Host** and **Mail Domain**. Once the Virtual Instance is created that host should be reachable without further action.

e.g. create a new host using:

- **WebId**: `two.dxp.docker.localhost`
- **Virtual Host**: `two.dxp.docker.localhost`
- **Mail Domain**: `two.dxp.docker.localhost`
- Wait for completion then access the VI at http://two.dxp.docker.localhost
