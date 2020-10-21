#!/bin/bash
# Author: Kicky
# Steps from the kubernetes documentation page that we executed yesterday
# Base work which is common to all the master and worker components

apt-get update
apt-get install -y docker.io apt-transport-https curl 
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
ls -ltr /etc/apt/sources.list.d/kubernetes.list
apt-get update -y
apt-get install -y kubelet kubeadm kubectl
systemctl enable docker >/dev/null 2>&1
systemctl start docker
systemctl enable kubelet >/dev/null 2>&1
systemctl start kubelet >/dev/null 2>&1
# Enable ssh
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
systemctl restart sshd
echo -e "kubesecret\nkubesecret" | passwd root

