# Kubernetes Cluster on RHEL (CentOS, Rocky, AlmaLinux)

This guide explains how to install a Kubernetes cluster on RHEL-family systems using `kubeadm` and `containerd`.

## 🖥️ Prerequisites

- CentOS/RHEL/Rocky 8 or newer
- At least 2 GB RAM per node
- sudo/root access

##  Setup Steps

### 1.  On Master Node

``` bash
chmod +x install-master.sh
./install-master.sh
```
This installs Kubernetes tools, sets up containerd, disables SELinux, opens ports, and initializes the control plane.

After setup, it will print a join command. Save it.

### 2.  On Worker Node
``` bash
chmod +x install-worker.sh
./install-worker.sh
```
Then, run the join command you saved from the master node output.

### 3. To Delete the Cluster
``` bash
chmod +x delete-k8s.sh
./delete-k8s.sh
```

