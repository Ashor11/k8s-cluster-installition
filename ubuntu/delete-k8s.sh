#!/bin/bash

# Uninstall Kubernetes Cluster and containerd on Ubuntu/Debian

set -e

echo " Resetting Kubernetes cluster..."
sudo kubeadm reset -f

echo " Stopping and disabling kubelet and containerd..."
sudo systemctl stop kubelet || true
sudo systemctl disable kubelet || true
sudo systemctl stop containerd || true
sudo systemctl disable containerd || true

echo " Removing Kubernetes and containerd packages..."
sudo apt-get purge -y kubeadm kubectl kubelet kubernetes-cni kube*
sudo apt-get purge -y containerd.io containerd
sudo apt-get autoremove -y

echo " Deleting Kubernetes and containerd config files..."
sudo rm -rf /etc/cni /opt/cni /var/lib/cni
sudo rm -rf /var/lib/kubelet /etc/kubernetes ~/.kube
sudo rm -rf /etc/containerd /var/lib/containerd

echo " Reloading systemd..."
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl reset-failed

echo -e "\n Kubernetes and containerd have been fully uninstalled."
which kubelet || echo "kubelet not found"
which containerd || echo "containerd not found"
kubectl version || echo "kubectl not found"
