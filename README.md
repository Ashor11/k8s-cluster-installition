# k8s-cluster-installition 
# Kubernetes Cluster Setup Scripts

This repository provides automated bash scripts to install, configure, and remove a Kubernetes cluster (control plane and worker nodes) using `kubeadm`, `containerd`, and `flannel`.

> Supports both **RHEL-based** systems (CentOS, Rocky Linux, AlmaLinux) and **Ubuntu-based** systems.

## 📁 Repository Structure
```

├── rhel/
│ ├── install-master.sh # Script to setup control plane on RHEL
│ ├── install-worker.sh # Script to join worker node on RHEL
│ └── delete-k8s.sh # Script to uninstall cluster on RHEL
├── ubuntu/
│ ├── install-master.sh # Script to setup control plane on Ubuntu
│ ├── install-worker.sh # Script to join worker node on Ubuntu
│ └── delete-k8s.sh # Script to uninstall cluster on Ubuntu

```

## ✅ Features

- Sets up `containerd` and `kubeadm`
- Configures system modules and sysctl
- Sets firewall ports (optional)
- Initializes control plane with Flannel CNI
- Auto-generates the worker join command
- Includes a clean uninstall script

## 🚀 Quick Start

Choose your OS:

- [RHEL-based Instructions](./rhel/README.md)
- [Ubuntu-based Instructions](./ubuntu/README.md)
