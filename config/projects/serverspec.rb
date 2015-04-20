name "serverspec"
maintainer "HiganWorks LLC"
homepage "higanworks.com"

replace         "serverspec"
install_dir     "/opt/serverspec"

require 'json'
require 'open-uri'
s_versions = JSON.parse(open('https://rubygems.org/api/v1/versions/serverspec.json').read)
s_versions.select! {|r| r.has_key?('number')}
s_versions.select! {|r| r['number'].match(/^[\d]+\.[\d]+\.[\d]+$/)}

build_version   s_versions.first['number']

override_build_iteration = ENV['BUILD_ITERATION'].to_i || 1
override_build_iteration = 1 if override_build_iteration == 0

build_iteration override_build_iteration

# creates required build directories
dependency "preparation"

# serverspec dependencies/components

## Cert updates
# override :cacerts,
# version: "2015.02.25",
# source: {
# md5: "19e7f27540ee694308729fd677163649"
# }

## Ruby build 2.2.0 has CFLAG issue? (https://github.com/sstephenson/ruby-build/issues/690)

override :ruby,
  version: "2.2.2",
  source: {
  md5: "326e99ddc75381c7b50c85f7089f3260"
}
description "The full stack of serverspec with ruby 2.2.2"

dependency "ruby"
override :rubygems, version: "2.4.6"
dependency "rubygems"
override :bundler, version: '1.9.4'
dependency "bundler"
dependency "serverspec"

# Addons
dependency "curl"


# version manifest file
dependency "version-manifest"

exclude "\.git*"
exclude "bundler\/git"
