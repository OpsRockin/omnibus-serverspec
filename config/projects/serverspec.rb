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

## OpenSSL URL Changed(old)
# example to get latest
# body = open("https://www.openssl.org/source/").read
# doc = Nokogiri::HTML.parse(body)
# doc.xpath('//*[@id="content"]/div/article/div/table/tr[2]/td[3]/a[1]')[0].text
# => "openssl-1.1.1f.tar.gz"
openssl_version = '1.1.1f'
override :openssl,
  version: openssl_version,
  source: {
    # url: "https://www.openssl.org/source/old/1.0.2/openssl-1.0.2u.tar.gz" # for omnibus default version
    sha256: open("https://www.openssl.org/source/openssl-#{openssl_version}.tar.gz.sha256").read.chomp
  }

## Cert updates
# override :cacerts,
#   version: "2016.01.22",
#   source: {
#   md5: "36eee0e80373937dd90a9a334ae42817",
#   url: 'https://raw.githubusercontent.com/bagder/ca-bundle/dfcc02c918b7bf40ed3a7f27a634c74ef4e80829/ca-bundle.crt'
# }

description "Serverspec and Specinfra #{si_versions.first['number']} with ruby 2.6.5"
override :ruby,
  version: "2.6.5",
  source: {
    sha256: "66976b716ecc1fd34f9b7c3c2b07bbd37631815377a2e3e85a5b194cfdcbed7d"
  }

dependency "ruby"

dependency "rubygems"
override :specinfra
dependency "specinfra"
dependency "serverspec"

# Addons
dependency "curl"

# version manifest file
dependency "version-manifest"

exclude "**/.git"
exclude "**/bundler/git"
