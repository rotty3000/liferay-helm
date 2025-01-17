# A Helm Chart for Liferay DXP

[![CI](https://github.com/LiferayCloud/liferay-helm-chart/actions/workflows/ci.yaml/badge.svg?branch=main)](https://github.com/LiferayCloud/liferay-helm-chart/actions/workflows/ci.yaml)

## Install the Chart

Add the chart repository `https://LiferayCloud.github.io/liferay-helm-chart/charts`

```shell
helm repo add liferay-helm-chart-repo https://LiferayCloud.github.io/liferay-helm-chart/charts
```

You can search the repo, e.g.:

```shell
$ helm search repo --devel liferay
NAME                               	CHART VERSION	APP VERSION	DESCRIPTION
liferay-helm-chart-repo/liferay	0.1.0        	latest     	A Liferay DXP Helm chart for Kubernetes
```

### [For Local Development](FOR_LOCAL_DEVELOPMENT.md)

### [For Production](FOR_PRODUCTION.md)

### [Release Management](RELEASE_MANAGEMENT.md)
