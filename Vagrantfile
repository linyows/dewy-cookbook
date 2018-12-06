# -*- mode: ruby -*-
# vi: set ft=ruby :

unless ENV['GITHUB_TOKEN']
  puts 'env GITHUB_TOKEN required'
  exit
end

Vagrant.configure(2) do |config|
  cmd_ubuntu = <<-CMD
    apt-get -yy update
    apt-get install -yy glibc-source gcc make libcurl4-gnutls-dev libjansson-dev vim valgrind systemd-coredump
    timedatectl set-timezone Asia/Tokyo
  CMD

  cmd_centos = <<-CMD
    yum install -y glibc gcc make libcurl-devel jansson-devel git vim valgrind
  CMD

  def configure(chef)
    chef.cookbooks_path = %w(cookbooks)
    chef.roles_path = 'roles'
    chef.environments_path = 'environments'
    chef.nodes_path = 'vagrant_nodes'
    chef.data_bags_path = 'data_bags'
    chef.encrypted_data_bag_secret_key_path = '.chef/secret_data_bag_key'
    chef.environment = 'development'
    chef.version = '13.10.0'
  end

  config.vm.define :ubuntu do |c|
    c.vm.box = 'ubuntu/bionic64'
    c.vm.provision 'shell', inline: cmd_ubuntu + cmd
    c.vm.provision :chef_zero do |chef|
      configure chef
      chef.add_recipe 'dewy'
    end
  end

  config.vm.define :centos do |c|
    c.vagrant.plugins = 'vagrant-vbguest'
    c.vm.box = 'centos/7'
    c.vm.provision 'shell', inline: cmd_centos + cmd
    c.vm.provision :chef_zero do |chef|
      configure chef
      chef.add_recipe 'dewy'
    end
  end
end
