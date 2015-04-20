#!/usr/bin/env bash

set -e
RUBYPATH="/opt/rubies/ruby-2.1.5/bin"
BUILD_ITERATION=${CIRCLE_BUILD_NUM:-1}

bundle exec kitchen destroy
bundle exec kitchen converge

bundle exec kitchen exec all -c "export PATH=${RUBYPATH}:\$PATH; gem install bundler --no-ri --no-rdoc"
bundle exec kitchen exec all -c "export PATH=${RUBYPATH}:\$PATH; cd /home/vagrant/serverspec; bundle install --jobs=2 --verbose --binstubs --without development"
bundle exec kitchen exec all -c "export PATH=${RUBYPATH}:\$PATH; export HOME=/home/vagrant ; export BUILD_ITERATION=${BUILD_ITERATION} ;cd /home/vagrant/serverspec; ./bin/omnibus build serverspec"
