#!/usr/bin/env bash

set -e
rake release_to_packagecloud[$CIRCLE_BRANCH,$1,$2]
rake yank_oldest_release[$CIRCLE_BRANCH,$1]

rake bintray:release
rake bintray:yank_oldest
