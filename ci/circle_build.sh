#!/usr/bin/env bash

bundle exec kitchen destroy
bundle exec kitchen converge

bundle exec kitchen exec all -c 'git clone https://github.com/OpsRockin/omnibus-serverspec.git serverspec'
bundle exec kitchen exec all -c 'gem install bundler --no-ri --no-rdoc --without=developmet'
bundle exec kitchen exec all -c 'cd serverspec; bundle install --jobs=2 --verbose --binstubs'
bundle exec kitchen exec all -c 'cd serverspec; ./bin/omnibus build project serverspec'
# kitchen destroy
