#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

# Install docker.io and dependencies
echo "[TASK 1] Install docker container engine"
apt-get -qq update && apt-get -qq upgrade 
apt-get install -qq curl wget thin-provisioning-tools lvm2 software-properties-common docker.io 

# Enable docker service
echo "[TASK 2] Enable and start docker service"
systemctl enable docker && systemctl start docker

# Add repo file for Kubernetes
echo "[TASK 3] Add apt repo file for kubernetes"
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add 
apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main" 
apt-get -qq update

# Install Kubernetes
echo "[TASK 4] Install Kubernetes (kubeadm, kubelet and kubectl)"
swapoff -a
apt-get install -qq kubeadm kubelet kubectl

# Start and Enable kubelet service
echo "[TASK 5] Enable and start kubelet service"
systemctl enable kubelet
systemctl start kubelet 

# Install Openssh server
echo "[TASK 6] Install and configure ssh"
apt-get -qq install openssh-server
systemctl enable sshd >/dev/null 2>&1
systemctl start sshd >/dev/null 2>&1

# Set Root password
echo "[TASK 7] Set root password"
echo root:kubeadmin | /usr/sbin/chpasswd  

# Install additional required packages
echo "[TASK 8] Install additional packages"
apt-get -qq install net-tools sudo sshpass less 

#######################################
# To be executed only on master nodes #
#######################################

if [[ $(hostname) == k8s-master ]]
then

  # Initialize Kubernetes
  echo "[TASK 9] Initialize Kubernetes Cluster"
  kubeadm init --pod-network-cidr=10.244.0.0/16 --ignore-preflight-errors=Swap,FileContent--proc-sys-net-bridge-bridge-nf-call-iptables,SystemVerification >> /root/kubeinit.log 

  # Copy Kube admin config
  echo "[TASK 10] Copy kube admin config to root user .kube directory"
  mkdir -p /root/.kube
  cp /etc/kubernetes/admin.conf /root/.kube/config

  # Deploy flannel network
  echo "[TASK 11] Deploy flannel network"
  kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml 

else

  # Generate Cluster join command
  echo "[TASK 9] Generate and save cluster join command to /joincluster.sh"
  joinCommand=$(kubeadm token create --print-join-command) 
  echo "$joinCommand --ignore-preflight-errors=Swap,FileContent--proc-sys-net-bridge-bridge-nf-call-iptables,SystemVerification" > /joincluster.sh


  # Join worker nodes to the Kubernetes cluster
  echo "[TASK 10] Join node to Kubernetes Cluster"
  bash /joincluster.sh >> /tmp/joincluster.log 

fi