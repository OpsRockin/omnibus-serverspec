#!/usr/bin/env bash

bundle exec rake
bundle exec kitchen destroy
bundle exec rake release
