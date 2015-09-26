#!/usr/bin/env bash

set -e
BUILD_ITERATION=${CIRCLE_BUILD_NUM:-1}

bundle exec kitchen destroy
bundle exec kitchen converge

bundle exec kitchen exec all -c "source /home/vagrant/load-omnibus-toolchain.sh ; cd /home/vagrant/serverspec; bundle install --jobs=2 --verbose --binstubs --without development"
bundle exec kitchen exec all -c "source /home/vagrant/load-omnibus-toolchain.sh ; export HOME=/home/vagrant ; export BUILD_ITERATION=${BUILD_ITERATION} ;cd /home/vagrant/serverspec; ./bin/omnibus build serverspec"
