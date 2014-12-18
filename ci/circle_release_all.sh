#!/usr/bin/env bash

set -e

bundle exec kitchen destroy
bundle exec package_cloud push omnibus-serverspec/serverspec/el/6 pkg/*.rpm
bundle exec package_cloud push omnibus-serverspec/serverspec/ubuntu/trusty pkg/*.deb
