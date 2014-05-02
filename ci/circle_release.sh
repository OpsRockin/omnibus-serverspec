#!/usr/bin/env bash

set -e

bundle exec rake sync
# bundle exec kitchen destroy
bundle exec rake release
