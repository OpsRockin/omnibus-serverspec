#!/usr/bin/env bash

set -e
RAKE="bundle exec rake"
$RAKE packagecloud:release[$CIRCLE_BRANCH,$1,$2]
$RAKE packagecloud:yank_oldest[$CIRCLE_BRANCH,$1]

$RAKE bintray:release
$RAKE bintray:yank_oldest
