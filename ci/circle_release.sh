#!/usr/bin/env bash

set -e
rake release_to_packagecloud[$CIRCLE_BRANCH,el/6,'rpm']
rake yank_oldest_release[$CIRCLE_BRANCH,el/6]

rake release_to_packagecloud[$CIRCLE_BRANCH,el/7,'rpm']
rake yank_oldest_release[$CIRCLE_BRANCH,el/7]

rake release_to_packagecloud[$CIRCLE_BRANCH,ubuntu/trusty,'deb']
rake yank_oldest_release[$CIRCLE_BRANCH,ubuntu/trusty]
