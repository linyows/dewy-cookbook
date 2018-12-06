# Cookbook Name:: dewy
# Recipe:: install

package 'curl'

execute 'systemctl daemon-reload' do
  action :nothing
end

if node['dewy']['group'] != 'nobody'
  group node['dewy']['group'] do
    system true
  end
end

if node['dewy']['user'] != 'nobody'
  user node['dewy']['user'] do
    shell '/bin/false'
    system true
    gid node['dewy']['group']
    comment 'Service user for dewy'
  end
end

execute 'download and extract' do
  cwd node['dewy']['bin']
  command <<-CMD
    link=$(curl -s #{node['dewy']['github_api']}/#{node['dewy']['version']} | grep browser_download_url | grep #{node['dewy']['asset']} | awk '{print $2}' | tr -d '"')
    curl -LJOs -H 'Accept: application/octet-stream' $link
    rm -f dewy
    tar xvf #{node['dewy']['asset']}
    rm -f #{node['dewy']['asset']}
    chown #{node['dewy']['user'] == 'nobody' ? 'root' : node['dewy']['user']}:#{node['dewy']['group'] == 'nobody' ? 'root' : node['dewy']['group']} dewy
  CMD
  only_if { !File.exists?("#{node['dewy']['bin']}/dewy") || node['dewy']['replace'] }
end

directory node['dewy']['dir'] do
  mode '0755'
  owner node['dewy']['user']
  group node['dewy']['group']
end
