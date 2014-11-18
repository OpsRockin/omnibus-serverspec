name "serverspec"
require 'json'
require 'open-uri'

s_versions = JSON.parse(open('https://rubygems.org/api/v1/versions/serverspec.json').read)
s_versions.select! {|r| r.has_key?('number')}
default_version s_versions.first['number'] # Rubygems Option
gem_version = s_versions.first['number']   # local_variable

dependency "ruby"
dependency "rubygems"
dependency "bundler"

#source :git => "https://github.com/serverspec/serverspec.git"
#relative_path "serverspec"

env = {
  "PATH" => "#{install_dir}/embedded/bin:#{ENV["PATH"]}"
}

build do
  command "#{install_dir}/embedded/bin/gem install serverspec --no-ri --no-rdoc --version=#{gem_version}", :env => env
  command "ln -fs #{install_dir}/embedded/bin/serverspec-init #{install_dir}/bin/serverspec-init", :env => env
end
