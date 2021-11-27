
kubectl taint node controlplane node-role.kubernetes.io/master-


curl -sfL https://raw.githubusercontent.com/OpenFunction/OpenFunction/main/hack/deploy.sh | bash -s  -- --all



intall nginx issue: https://github.com/kubernetes/ingress-nginx/issues/7810