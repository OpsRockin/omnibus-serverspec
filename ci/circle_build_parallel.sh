#!/usr/bin/env bash

set -e
case $CIRCLE_NODE_INDEX in
  0) TARGET="centos"
    ;;
  1) TARGET="ubuntu"
    ;;
esac

BUILD_ITERATION=${CIRCLE_BUILD_NUM:-1}

sudo chown ubuntu.ubuntu ${HOME}/.vagrant.d
bundle exec kitchen converge ${TARGET}

bundle exec kitchen exec ${TARGET} -c "source /home/vagrant/load-omnibus-toolchain.sh ; cd /home/vagrant/serverspec; bundle install --jobs=2 --verbose --binstubs --without development"
bundle exec kitchen exec ${TARGET} -c "source /home/vagrant/load-omnibus-toolchain.sh ; export HOME=/home/vagrant ; export BUILD_ITERATION=${BUILD_ITERATION}; cd /home/vagrant/serverspec; ./bin/omnibus build serverspec"
