### Prerequisites

The latest version of OpenFunction requires that you have a Kubernetes cluster with version ``>=1.19.0``.

1. Make sure your Kubernetes version is compatible by running kubectl version{{execute}} in your cluster node.
   > Pay attention to Server Version line, if GitVersion is greater than v1.19.0, it's good to go
2. Untaint master node: `kubectl taint node controlplane node-role.kubernetes.io/master-`
3. Setup OpenFunction **Builder** and **Serving**: `curl -sfL https://raw.githubusercontent.com/OpenFunction/OpenFunction/main/hack/deploy.sh | bash -s  -- --with-shipwright --with-openFuncAsync --with_cert_manager`