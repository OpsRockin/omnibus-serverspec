#!/usr/bin/env bash
set -e

case $CIRCLE_NODE_INDEX in
  0) TARGET="centos"
    ;;
  1) TARGET="ubuntu"
    ;;
esac

bundle exec kitchen destroy ${TARGET}
