#!/bin/bash

set -xe

find /opt/pkg/ -name "*rpm" -exec rpm -ivh {} \;
/opt/serverspec/embedded/bin/ruby -r serverspec -e 'puts Serverspec::VERSION'
