# Cookbook Name:: dewy
# Recipe:: setup

template "#{node['dewy']['sysconfig_dir']}/dewy" do
  source 'sysconfig.dewy.erb'
  mode '644'
  owner 'root'
  group 'root'
  action :create
  cookbook node['dewy']['sysconfig_cookbook']
  notifies :restart, 'service[dewy]', :delayed
end

template "#{node['dewy']['systemd_unit_dir']}/dewy.service" do
  source 'dewy.service.erb'
  mode '644'
  owner 'root'
  group 'root'
  action :create
  cookbook node['dewy']['systemd_cookbook']
  notifies :run, 'execute[systemctl daemon-reload]', :delayed
  notifies :restart, 'service[dewy]', :delayed
end

service 'dewy' do
  supports status: true, restart: true, reload: true
  action %i(enable start)
end
