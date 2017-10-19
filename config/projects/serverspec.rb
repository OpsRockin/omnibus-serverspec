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

si_versions = JSON.parse(open('https://rubygems.org/api/v1/versions/specinfra.json').read)
si_versions.select! {|r| r.has_key?('number')}
si_versions.select! {|r| r['number'].match(/^[\d]+\.[\d]+\.[\d]+$/)}

build_version   s_versions.first['number']

override_build_iteration = ENV['BUILD_ITERATION'].to_i || 1
override_build_iteration = 1 if override_build_iteration == 0

build_iteration override_build_iteration

# creates required build directories
dependency "preparation"

# serverspec dependencies/components

## Cert updates
# override :cacerts,
#   version: "2016.01.22",
#   source: {
#   md5: "36eee0e80373937dd90a9a334ae42817",
#   url: 'https://raw.githubusercontent.com/bagder/ca-bundle/dfcc02c918b7bf40ed3a7f27a634c74ef4e80829/ca-bundle.crt'
# }

description "Serverspec and Specinfra #{si_versions.first['number']} with ruby 2.4.2"
override :ruby, version: "2.4.2",
  source: {
    sha256: "93b9e75e00b262bc4def6b26b7ae8717efc252c47154abb7392e54357e6c8c9c"
  }

dependency "ruby"

dependency "rubygems"
override :bundler, version: '1.15.4'
dependency "bundler"
override :specinfra
dependency "specinfra"
dependency "serverspec"

# Addons
dependency "curl"

# version manifest file
dependency "version-manifest"

exclude "**/.git"
exclude "**/bundler/git"
