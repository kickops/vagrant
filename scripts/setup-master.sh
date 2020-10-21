#!/bin/bash
# Author: Kicky
# Setup Master node - Control plane components

int_ip="192.168.5.10"
pod_cidr="10.144.0.0/16"

kubeadm init --apiserver-advertise-address=$int_ip --pod-network-cidr=$pod_cidr >> /root/kubeinstall.log 2>/dev/null
mkdir /home/vagrant/.kube ~/.kube
cp /etc/kubernetes/admin.conf ~/.kube/config
cp /etc/kubernetes/admin.conf /home/vagrant/.kube/config
chown -R vagrant:vagrant /home/vagrant/.kube
kubeadm token create --print-join-command > /nodescript.sh
chmod +x /nodescript.sh

# Network Add-ON
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"
