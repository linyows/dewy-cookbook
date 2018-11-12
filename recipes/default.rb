# Cookbook Name:: dewy
# Recipe:: default

package 'curl'

api = 'https://api.github.com/repos/linyows/dewy/releases/latest'
tar = 'dewy_linux_amd64.tar.gz'

execute 'download and extract' do
  cwd '/usr/bin'
  command <<-CMD
    link=$(curl -s #{api} | grep browser_download_url | grep #{tar} | awk '{print $2}' | tr -d '"')
    curl -LJOs -H 'Accept: application/octet-stream' $link
    rm -f dewy
    tar xvf #{tar}
    rm -f #{tar}
  CMD
end

directory node['dewy']['app_dir'] do
  mode '0755'
  owner node['dewy']['app_user']
  group node['dewy']['app_group']
end

template '/etc/default/dewy' do
  source 'sysconfig.dewy.erb'
  mode '644'
  owner 'root'
  group 'root'
  action :create
end

template '/etc/systemd/system/dewy.service' do
  source 'dewy.service.erb'
  mode '644'
  owner 'root'
  group 'root'
  action :create
  notifies :run, 'execute[systemctl daemon-reload]', :delayed
end

service 'dewy' do
  supports status: true, restart: true, reload: true
  action %i(enable start)
end
