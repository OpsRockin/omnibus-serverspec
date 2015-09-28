# FROM opsrock/omnibus_base_ubuntu14
FROM ub:latest
MAINTAINER sawanoboriyu@higanworks.com

ADD . /home/omnibus/omnibus-serverspec
ADD docker/build.sh /home/omnibus/omnibus-serverspec/build.sh

WORKDIR /home/omnibus/omnibus-serverspec
RUN bash -c 'source /home/omnibus/load-omnibus-toolchain.sh ; bundle install --binstubs bundle_bin --without development test ship'

VOLUME ["pkg", "/home/omnibus/omnibus-serverspec/pkg"]
CMD ["./build.sh"]
