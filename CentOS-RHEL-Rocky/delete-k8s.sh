#!/bin/bash

# Uninstall Kubernetes Cluster and containerd
# Tested on CentOS/RHEL/Rocky Linux

set -e

# Step 1: Reset Kubernetes cluster
sudo kubeadm reset -f

# Step 2: Stop and disable services
sudo systemctl stop kubelet || true
sudo systemctl disable kubelet || true

sudo systemctl stop containerd || true
sudo systemctl disable containerd || true

# Step 3: Remove Kubernetes packages
sudo yum remove -y kubeadm kubectl kubelet kubernetes-cni kube*

# Step 4: Remove containerd
sudo yum remove -y containerd.io containerd

# Step 5: Clean up network and Kubernetes configs
sudo rm -rf /etc/cni
sudo rm -rf /opt/cni
sudo rm -rf /var/lib/cni
sudo rm -rf /var/lib/kubelet
sudo rm -rf /etc/kubernetes
sudo rm -rf ~/.kube

# Step 6: Clean up containerd data
sudo rm -rf /etc/containerd
sudo rm -rf /var/lib/containerd

# Step 7: Reload systemd and cleanup
sudo systemctl daemon-reload
sudo systemctl reset-failed

# Step 8: Confirm removal (optional)
echo "\nCheck removal:"
which kubelet || echo "kubelet not found"
which containerd || echo "containerd not found"
kubectl version || echo "kubectl not found"

echo "\n Kubernetes and containerd fully uninstalled."
