#-*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Every Vagrant virtual environment requires a box to build off of.
  #centos 6.5
  config.vm.box = "chef/centos-6.5"

  # Configurate the virtual machine to use 2GB of RAM
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "2048"]
  end

  #this will make sure :chef_solo is installed on the VM
  config.omnibus.chef_version = :latest

  # Forward the Rails server default port to the host
  config.vm.network :forwarded_port, guest: 6000, host: 6000, auto_correct: true

  # Use Chef Solo to provision our virtual machine
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ["cookbooks", "site-cookbooks"]

    chef.add_recipe "yum"
    chef.add_recipe "nodejs"
    chef.add_recipe "ruby_build"
    chef.add_recipe "rvm::user"
    chef.add_recipe "rvm::vagrant"
    chef.add_recipe "vim"
    chef.add_recipe "mysql::server"
    chef.add_recipe "mysql::client"

    # Install Ruby 1.9.3-p547 and Bundler
    # Set an empty root password for MySQL to make things simple
    chef.json = {
      rvm: {
        user_installs: [{
          user: 'vagrant',
          rubies: ["1.9.3-p547"],
          global: "1.9.3-p547",
          gems: {
            "1.9.3-p547" => [
              { name: "bundler" }
            ]
          }
        }]
      },
      mysql: {
        server_root_password: ''
      }
    }
  end
end
