# Cookbook Name: dewy
# Attribute: default

default['dewy']['dir']                = '/opt/dewy-testapp'
default['dewy']['command']            = "server -r linyows/dewy-testapp -a dewy-testapp_linux_amd64.tar.gz -- #{node['dewy']['dir']}/current/dewy-testapp"

default['dewy']['version']            = 'latest'
default['dewy']['github_api']         = 'https://api.github.com/repos/linyows/dewy/releases'
default['dewy']['asset']              = 'dewy_linux_amd64.tar.gz'

default['dewy']['user']               = 'nobody'
default['dewy']['group']              = 'nobody'
default['dewy']['bin']                = '/usr/bin'
default['dewy']['systemd_cookbook']   = 'dewy'
default['dewy']['sysconfig_cookbook'] = 'dewy'

case node['platform_family']
when 'rhel', 'fedora'
  default['dewy']['sysconfig_dir']    = '/etc/sysconfig'
  default['dewy']['systemd_unit_dir'] = '/usr/lib/systemd/system'
when 'debian'
  default['dewy']['sysconfig_dir']    = '/etc/default'
  default['dewy']['systemd_unit_dir'] = '/lib/systemd/system'
end

default['dewy']['github_token']       = ''
default['dewy']['github_endpoint']    = ''
default['dewy']['slack_token']        = ''
default['dewy']['slack_channel']      = ''
