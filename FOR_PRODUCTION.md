## For Production

When installing into production it is best to start by creating a custom values file.

`custom-values.yaml`:

```yaml
# Custom Values
config: {}
```

Once the file has all the necessary configuration it can be supplied to the helm install command as follows:

```shell
helm upgrade -i liferay -n liferay-system --create-namespace -f custom-values.yaml liferay-helm-chart-repo/liferay
```

### Disable internal services

It is often necessary to disable the internally defined Postgres, Elasticsearch and MinIO services in order to use externally configured versions.

```yaml
elasticsearch:
  internal:
    enabled: false
postgres:
  internal:
    enabled: false
s3:
  internal:
    enabled: false
```

### Configure external services

It is still necessary to provide Liferay DXP with appropriate services:

```yaml
elasticsearch:
  internal:
    enabled: false
  config:
    clusterName: <cluster_name>
    host: <host>
    password: <password>
    port: <port>
    user: <username>

postgres:
  internal:
    enabled: false
  config:
    database: <database>
    host: <host>
    parameters: <connection_string_parameters>
    password: <password>
    port: <port>
    user: <username>

s3:
  internal:
    enabled: false
  config:
    user: <username>
    password: <password>
    buckets: <bucket_name>
    host: <host>
    region: <region>
    scheme: <scheme>
    pathStyle: <true|false>
    ports:
      api: <api_port>
```

## Configuring Liferay DXP

### Configuring the default instance account and hostname.

```yaml
# Custom Values
config:
  password: <dxp_admin_password>
  user: <dxp_admin_username>
  mainVirtualHost: <dxp_hostname>
```

### `portal.properties`

While you can pass a few parameters as above there are so many properties to configure Liferay DXP that this would become a painful modeling problem.

So, it is possible to pass `portal.properties` style configuration by using the following construct:

```yaml
configmap:
  data:
    portal-custom.properties: |
      #
      # Include any portal properties contents here preserving indentation.
      # This file will be mounted into the container and is already configured
      # to be read by Liferay DXP.
      #

      foo=bar
```

### Adding Liferay Docker Scripts

As described in the Liferay documentation you can [add scripts to the container](https://learn.liferay.com/w/dxp/installation-and-upgrades/installing-liferay/using-liferay-docker-images/running-scripts-in-containers) to be executed at various times in the lifecycle of the container.

To achieve this use the following construct:

```yaml
configmap:
  data:
    020_liferay_cloud_remove_dxp_trial_license.sh: |
      #!/bin/bash

      set -e

      remove_built_in_trial_dxp_license() {
        echo -e "[DXP Cloud] Remove built in trial license\n"

        find "${LIFERAY_HOME}/deploy" -name "*license-*.xml" -print -delete
      }

      echo -e "\n[DXP Cloud] Liferay Defaults"
      remove_built_in_trial_dxp_license

volumeMounts:
  - mountPath: /usr/local/liferay/scripts/pre-configure/020_liferay_cloud_remove_dxp_trial_license.sh
    name: liferay-file-resources
    subPath: 020_liferay_cloud_remove_dxp_trial_license.sh
    readOnly: true
```

This pattern can be used as many times as necessary.

### View Chart Values

To view the set of available chart values the following command can be used:

```shell
helm show values liferay-helm-chart-repo/liferay
```
