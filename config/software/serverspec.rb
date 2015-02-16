name "serverspec"
require 'json'
require 'open-uri'

s_versions = JSON.parse(open('https://rubygems.org/api/v1/versions/serverspec.json').read)
s_versions.select! {|r| r.has_key?('number')}
default_version s_versions.first['number'] # Rubygems Option
gem_version = s_versions.first['number']   # local_variable

#source :git => "https://github.com/serverspec/serverspec.git"
#relative_path "serverspec"

env = {
  "PATH" => "#{install_dir}/embedded/bin:#{ENV["PATH"]}"
}

build do
  gem 'serverspec'
  gem 'infrataster'
  gem 'winrm'
  gem 'docker-api'

  command "ln -fs #{install_dir}/embedded/bin/serverspec-init #{install_dir}/bin/serverspec-init", :env => env
  command "ln -fs #{install_dir}/embedded/bin/rspec #{install_dir}/bin/rspec", :env => env
  command "ln -fs #{install_dir}/embedded/bin/rake #{install_dir}/bin/rake", :env => env
end
