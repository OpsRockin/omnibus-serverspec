#!/usr/bin/env bash

set -ex
source /home/omnibus/load-omnibus-toolchain.sh
./bundle_bin/omnibus build serverspec
