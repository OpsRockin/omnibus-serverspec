name "serverspec"
maintainer "HiganWorks LLC"
homepage "higanworks.com"

# override :ruby, version: '2.1.1'
# override :rubygems, version: '2.2.1'

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
override :ruby, version: "2.1.5"
dependency "ruby"
dependency "rubygems"
dependency "bundler"
dependency "serverspec"

# version manifest file
dependency "version-manifest"

exclude "\.git*"
exclude "bundler\/git"
