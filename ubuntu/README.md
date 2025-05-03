
---

###  (For Ubuntu/Debian-based distros)

```markdown
# Kubernetes Cluster on Ubuntu

This guide explains how to install a Kubernetes cluster on Ubuntu systems using `kubeadm` and `containerd`.

## 🖥️ Prerequisites

- Ubuntu 20.04 or newer
- At least 2 GB RAM per node
- sudo/root access
```
##  Setup Steps

### 1.  On Master Node

```bash
chmod +x install-master.sh
./install-master.sh
```
Initializes the control plane using Flannel networking.

After setup, copy the generated join command for worker nodes.

### 2.  On Worker Node
```bash
chmod +x install-worker.sh
./install-worker.sh
```
Then run the join command provided by the master node to join the cluster.

### 3.  Verify Cluster
``` bash
kubectl get nodes
```
4. To Delete the Cluster
```bash
chmod +x delete-k8s.sh
./delete-k8s.sh
```
This script removes Kubernetes, containerd, and all related configuration.
