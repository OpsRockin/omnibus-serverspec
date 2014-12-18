#!/usr/bin/env bash

set -e

bundle exec kitchen destroy
bundle exec package_cloud push omnibus-serverspec/dummy_with_ci/el/6 pkg/*.rpm
bundle exec package_cloud push omnibus-serverspec/dummy_with_ci/ubuntu/trusty pkg/*.deb
