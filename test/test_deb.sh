#!/bin/bash

set -xe

find /opt/pkg/ -name "*deb" -exec dpkg -i {} \;
/opt/serverspec/embedded/bin/ruby -r serverspec -e 'puts Serverspec::VERSION'
