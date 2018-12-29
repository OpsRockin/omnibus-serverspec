name "serverspec"
require 'json'
require 'open-uri'

s_versions = JSON.parse(open('https://rubygems.org/api/v1/versions/serverspec.json').read)
s_versions.select! {|r| r.has_key?('number')}
default_version s_versions.first['number'] # Rubygems Option
gem_version = s_versions.first['number']   # local_variable

#source :git => "https://github.com/mizzy/serverspec.git"
#relative_path "serverspec"

env = with_embedded_path()

build do
  gem 'update --system'
  gem 'install serverspec --no-document'
  gem 'install infrataster --no-document'
  gem 'install winrm --no-document'
  gem 'install docker-api --no-document'
  gem 'install rspec_junit_formatter --no-document'
  gem 'install pry pry-doc --no-document'

  command "ln -fs #{install_dir}/embedded/bin/serverspec-init #{install_dir}/bin/serverspec-init", :env => env
  command "ln -fs #{install_dir}/embedded/bin/rspec #{install_dir}/bin/rspec", :env => env
  command "ln -fs #{install_dir}/embedded/bin/rake #{install_dir}/bin/rake", :env => env
end
