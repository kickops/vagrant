#!/bin/bash
# Author: Kicky
# Join worker nodes to cluster

apt-get install -y sshpass >/dev/null 2>&1
sshpass -p "kubesecret" scp -o StrictHostKeyChecking=no kubemaster:/nodescript.sh /nodescript.sh
bash /nodescript.sh >/dev/null 2>&1
