#!/bin/bash

wait_for_k8s_cluster_start() {
  echo Waiting for Kubernetes to start...
    while [ ! -f /root/.kube/config ]
    do
      sleep 1
    done
  echo Kubernetes started
  if [ -f /root/.kube/start ]; then
    /root/.kube/start
  fi
}

wait_for_nodeready() {
  if [[ $# -lt 1 ]];then
    echo "wait_for_nodeready function call error, expect a parameter about node name"
    return 1
  fi
  echo "Wating for Kubernetes node $1 to ready..."
  status=$(kubectl get node ${1} | sed '1d' | awk '{print $2}')
  while [ ${status} != "Ready" ]
  do
    sleep 5
  done
  echo "Node ${1} status is now: NodeReady"
}

upgrade_k8s_version() {
  if [[ $# -lt 1 ]];then
    echo "upgrade_k8s_version function call error, expect a parameter about k8s package version(1.19.0,1.20.0..)"
    return 1
  fi
  echo "Waiting for upgrade kubernetes vertion to v$1..."
  apt-get update -y > /dev/null 2>&1 && apt-get install -y --allow-change-held-packages kubelet=$1-00 kubectl=$1-00 kubeadm=$1-00 > /dev/null 2>&1
  kubeadm config images pull --kubernetes-version $1 > /dev/null 2>&1
  kubeadm upgrade apply v$1 --yes --ignore-preflight-errors=all > /dev/null 2>&1
  ssh node01 "apt-get install -y kubelet=$1-00 kubectl=$1-00 > /dev/null 2>&1"
  wait_for_nodeready controlplane
  wait_for_nodeready node01
  echo "kubernetes version is now: v$1"
}

# start k8s cluster when katacoda runtime start
wait_for_k8s_cluster_start

# waiting for k8s node
wait_for_nodeready controlplane
wait_for_nodeready node01

upgrade_k8s_version 1.19.0

