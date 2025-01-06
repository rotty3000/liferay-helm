### Deploy Helm Chart

```shell
helm upgrade -i foo .
```

## Uninstall Helm Chart

```shell
helm uninstall foo .
```

### Watch resources

```shell
alias kall='k get -A all,cm,ingress,sa,pvc --field-selector=metadata.namespace!=kube-system'
alias w='watch -n.5 '
w kall
```

### Watch Events

```shell
k get events -w
```

### Watch Logs (with string `foo`)

```shell
k stern foo
```
