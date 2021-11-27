### Install OpenFunction

You can install the OpenFunction platform by the following command:

- Install the latest stable version

```shell
kubectl create -f https://github.com/OpenFunction/OpenFunction/releases/download/v0.4.0/bundle.yaml
```

- Install the development version

```shell
kubectl create -f https://raw.githubusercontent.com/OpenFunction/OpenFunction/main/config/bundle.yaml
```

> Note: When using non-default namespaces, make sure that the ClusterRoleBinding in the namespace is adapted.

### Verify the installation

```bash
kubectl get pods --namespace openfunction

NAME                                               READY   STATUS    RESTARTS   AGE
openfunction-controller-manager-6955498c9b-hjql7   2/2     Running   0         2m2s
```


intall nginx issue: https://github.com/kubernetes/ingress-nginx/issues/7810