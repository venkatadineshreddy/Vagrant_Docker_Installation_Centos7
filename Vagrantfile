# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version ">= 1.6.0"

boxes = [
    {
        :name => "docker-host",
        :eth1 => "192.168.56.56",
		:eth2 => "192.168.56.57",
        :mem => "1024",
        :cpu => "1"
    }
]

Vagrant.configure(2) do |config|
if Vagrant.has_plugin?("vagrant-proxyconf")
    config.proxy.http     = "http://10.144.1.10:8080/"
    config.proxy.https    = "http://10.144.1.10:8080/"
end
  config.vm.box = "centos/7"
  boxes.each do |opts|
    config.vm.define opts[:name] do |config|
      config.vm.hostname = opts[:name]
      config.vm.provider "vmware_fusion" do |v|
        v.vmx["memsize"] = opts[:mem]
        v.vmx["numvcpus"] = opts[:cpu]
      end
      config.vm.provider "virtualbox" do |v|
        v.customize ["modifyvm", :id, "--memory", opts[:mem]]
        v.customize ["modifyvm", :id, "--cpus", opts[:cpu]]
      end
      config.vm.network :private_network, ip: opts[:eth1]
	  config.vm.network :private_network, ip: opts[:eth2]
    end
  end
#  config.vm.provision "shell", privileged: true, path: "./setup.sh"
  config.vm.provision "shell", privileged: true, path: "./proxy_setup.sh"
end
