#!/usr/bin/env bash

set -e
case $CIRCLE_NODE_INDEX in
  0) TARGET="centos"
    ;;
  1) TARGET="ubuntu"
    ;;
esac

RUBYPATH="/opt/rubies/ruby-2.1.5/bin"
BUILD_ITERATION=${CIRCLE_BUILD_NUM:-1}

bundle exec kitchen create ${TARGET}  ## When droplet exists, collect id from D.O.
bundle exec kitchen destroy ${TARGET} ## and destroy it to clear cache.
sleep 10 # wait destroying.
sudo chown ubuntu.ubuntu ${HOME}/.vagrant.d
bundle exec kitchen converge ${TARGET}

bundle exec kitchen exec ${TARGET} -c "export PATH=${RUBYPATH}:\$PATH; gem install bundler --no-ri --no-rdoc"
bundle exec kitchen exec ${TARGET} -c "export PATH=${RUBYPATH}:\$PATH; cd /home/vagrant/serverspec; bundle install --jobs=2 --verbose --binstubs --without development"
bundle exec kitchen exec ${TARGET} -c "export PATH=${RUBYPATH}:\$PATH; export BUILD_ITERATION=${BUILD_ITERATION}; cd /home/vagrant/serverspec; ./bin/omnibus build serverspec"
