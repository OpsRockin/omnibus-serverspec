source 'https://rubygems.org'

# Install omnibus software
gem 'omnibus', '4.0.0'
gem 'omnibus-software', github: 'opscode/omnibus-software'

# Use Test Kitchen with Vagrant for convering the build environment
# gem 'rsync'
gem 'rake'

group :development do
  gem 'test-kitchen'
#  gem 'kitchen-vagrant'
#  gem 'kitchen-ec2'
  gem 'kitchen-digitalocean'
  # Use Berkshelf for resolving cookbook dependencies
#  gem 'berkshelf'
  gem 'librarian-chef'
  gem 'pry'
end

group :ship do
  gem 'package_cloud'
end
