name 'dewy'
maintainer 'linyows'
maintainer_email 'linyows@gmail.com'
license 'MIT'
description 'Installs/Configures dewy'
long_description 'Installs/Configures dewy'
version '0.3.1'

%w(centos).each do |os|
  supports os
end

# If you upload to Supermarket you should set this so your cookbook
# gets a `View Issues` link
issues_url 'https://github.com/linyows/dewy/issues' if respond_to?(:issues_url)

# If you upload to Supermarket you should set this so your cookbook
# gets a `View Source` link
source_url 'https://github.com/linyows/dewy' if respond_to?(:source_url)
