#!/bin/bash

# Kubernetes Control Plane Installation Script for Ubuntu/Debian

set -e

echo "🔧 Disabling swap..."
sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/' /etc/fstab

echo " Installing dependencies..."
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release

echo " Adding Kubernetes repo..."
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.32/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.32/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

echo " Installing containerd..."
sudo apt-get install -y containerd
sudo mkdir -p /etc/containerd
containerd config default | sudo tee /etc/containerd/config.toml >/dev/null
sudo sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml

echo "🔄 Enabling services..."
sudo systemctl restart containerd
sudo systemctl enable containerd
sudo systemctl enable kubelet

echo "📶 Configuring sysctl..."
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

sudo modprobe overlay
sudo modprobe br_netfilter
sudo sysctl --system

echo " Initializing control plane..."
MASTER_IP=$(hostname -I | awk '{print $1}')
sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=$MASTER_IP --upload-certs

echo " Configuring kubeconfig..."
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

echo " Installing Flannel network plugin..."
kubectl apply -f https://github.com/flannel-io/flannel/releases/latest/download/kube-flannel.yml

echo " Control plane setup complete!"
echo " Run the following on each worker node:"
kubeadm token create --print-join-command
