#!/usr/bin/env bash

set -e
rake packagecloud:release[$CIRCLE_BRANCH,$1,$2]
rake packagecloud:yank_oldest[$CIRCLE_BRANCH,$1]

rake bintray:release
rake bintray:yank_oldest
