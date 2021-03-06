name "specinfra"
require 'json'
require 'open-uri'

si_versions = JSON.parse(open('https://rubygems.org/api/v1/versions/specinfra.json').read)
si_versions.select! {|r| r.has_key?('number')}
default_version si_versions.first['number'] # Rubygems Option
gem_version = si_versions.first['number']   # local_variable

#source :git => "https://github.com/mizzy/specinfra.git"
#relative_path "specinfra"

env = with_embedded_path()

build do
  gem 'install specinfra --no-document'
end
