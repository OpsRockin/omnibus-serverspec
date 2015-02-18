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
override :ruby,
version: "2.2.0",
source: {
md5: "cd03b28fd0b555970f5c4fd481700852"
}
dependency "ruby"
override :rubygems, version: "2.4.5"
dependency "rubygems"
override :bundler, version: '1.8.2'
dependency "bundler"
dependency "serverspec"

## use mirror tempolary
override :zlib,
version: "1.2.6",
source: {
url: 'http://vorboss.dl.sourceforge.net/project/libpng/zlib/1.2.6/zlib-1.2.6.tar.gz'
}
dependency "zlib"

# Addons
dependency "curl"


# version manifest file
dependency "version-manifest"

exclude "\.git*"
exclude "bundler\/git"
