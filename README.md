# A Helm Chart for Liferay DXP

[![CI](https://github.com/rotty3000/liferay-helm/actions/workflows/ci.yaml/badge.svg?branch=main)](https://github.com/rotty3000/liferay-helm/actions/workflows/ci.yaml)

## Install the Chart

Add the chart repository `https://rotty3000.doublebite.com/liferay-helm/charts`

```shell
helm repo add liferay-helm https://rotty3000.doublebite.com/liferay-helm/charts
```

You can search the repo, e.g.:

```shell
$ helm search repo --devel liferay
NAME                               	CHART VERSION	APP VERSION	DESCRIPTION
rotty3000-liferay-helm/liferay-helm	0.1.0        	latest     	A Liferay DXP Helm chart for Kubernetes
```

### [For Local Development](FOR_LOCAL_DEVELOPMENT.md)

### [For Production](FOR_PRODUCTION.md)

### [Release Management](RELEASE_MANAGEMENT.md)
