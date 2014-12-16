#!/usr/bin/env bash
#!/usr/bin/env bash

set -e
if [ "${CIRCLE_BRANCH}" == "master" ]; then
  case $CIRCLE_NODE_INDEX in
    0) TARGET="centos"
      bundle exec kitchen destroy ${TARGET}
      bundle exec package_cloud push omnibus-serverspec/dummy_with_ci/el/6 pkg/*.rpm
      ;;
    1) TARGET="ubuntu"
      bundle exec kitchen destroy ${TARGET}
      bundle exec package_cloud push omnibus-serverspec/dummy_with_ci/ubuntu/trusty pkg/*.deb
      ;;
  esac
fi
