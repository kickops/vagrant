# Author: Kicky
# -*- mode: ruby -*-
# vi:set ft=ruby sw=2 ts=2 sts=2:

# Define the number of master and worker nodes
# If this number is changed, remember to update configure-hosts.sh script with the new hosts IP details in /etc/hosts of each VM.
MASTER_COUNT = 1
WORKER_COUNT = 2

ENV['VAGRANT_NO_PARALLEL'] = 'yes'

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"
  config.vm.box_check_update = false
  config.vm.provision "shell", path: "scripts/configure-hosts.sh"
  config.vm.provision "shell", path: "scripts/configure-dns.sh"
  config.vm.provision "shell", path: "scripts/install-base-components.sh"
 

  # Provision Master Nodes
      config.vm.define "kubemaster" do |node|
        # Name shown in the GUI
        node.vm.provider "virtualbox" do |vb|
            vb.name = "kubemaster"
            vb.memory = 2048
            vb.cpus = 2
        end
        node.vm.hostname = "kubemaster"
        node.vm.network :private_network, ip: "192.168.5.10"
        node.vm.network "forwarded_port", guest: 22, host: "2710"
       
        node.vm.provision "shell", path: "scripts/setup-master.sh"
      end


  # Provision Worker Nodes
  (1..WORKER_COUNT).each do |i|
    config.vm.define "kubenode#{i}" do |node|
        node.vm.provider "virtualbox" do |vb|
            vb.name = "kubenode#{i}"
            vb.memory = 2048
            vb.cpus = 2
        end
        node.vm.hostname = "kubenode#{i}"
        node.vm.network :private_network, ip: "192.168.5." + "#{2 + i}"
        node.vm.network "forwarded_port", guest: 22, host: "#{2720 + i}"
    
        node.vm.provision "shell", path: "scripts/setup-worker.sh"
    end
  end
end
