#!/usr/bin/env bash

set -e

bundle exec kitchen destroy
bundle exec kitchen converge

bundle exec kitchen exec all -c 'gem install bundler --no-ri --no-rdoc'
bundle exec kitchen exec all -c 'cd serverspec; bundle install --jobs=2 --verbose --binstubs'
bundle exec kitchen exec all -c 'cd serverspec; ./bin/omnibus build project serverspec'
