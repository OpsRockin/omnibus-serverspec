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

description "Serverspec and Specinfra #{si_versions.first['number']} with ruby 2.2.5"
override :ruby, version: "2.2.5"
  source: {
  md5: "bd8e349d4fb2c75d90817649674f94be"
}
dependency "ruby"

override :rubygems, version: "2.4.8"
dependency "rubygems"
override :bundler, version: '1.11.2'
dependency "bundler"
override :specinfra
dependency "specinfra"
dependency "serverspec"

# Addons
dependency "curl"

## Patch for sourceforge libs
# https://github.com/chef/omnibus-software/issues/695
override :zlib, source: {url: 'http://downloads.sourceforge.net/project/libpng/zlib/1.2.8/zlib-1.2.8.tar.gz'}
override :expat, source: {url: 'http://downloads.sourceforge.net/project/expat/expat/2.1.0/expat-2.1.0.tar.gz'}
override :pcre, source: {url: 'http://downloads.sourceforge.net/project/pcre/pcre/8.38/pcre-8.38.tar.gz'}


# version manifest file
dependency "version-manifest"

exclude "**/.git"
exclude "**/bundler/git"
