source 'https://rubygems.org'

# Use Berkshelf for resolving cookbook dependencies
gem 'berkshelf', '< 3.0.0'

# Install omnibus software
gem 'omnibus', '4.0.0.rc1'
gem 'omnibus-software', github: 'opscode/omnibus-software'

# Use Test Kitchen with Vagrant for convering the build environment
# gem 'rsync'
gem 'rake'

group :developmet do
  # gem 'test-kitchen',    '~> 1.2'
  gem 'test-kitchen', github: 'higanworks/test-kitchen'
  gem 'kitchen-vagrant', '~> 0.14'
  gem 'kitchen-ec2'
  gem 'kitchen-digitalocean'
  gem 'pry'
end
