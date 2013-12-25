name "serverspec"
version "v0.14.1"          # git ref
gem_version = '0.14.1'  # local_variable

dependency "ruby"
dependency "rubygems"
dependency "bundler"

#source :git => "https://github.com/serverspec/serverspec.git"
#relative_path "serverspec"

env = {
  "PATH" => "#{install_dir}/embedded/bin:#{ENV["PATH"]}"
}

build do
  command "sudo gem install serverspec --no-ri --no-rdoc --version=#{gem_version}", :env => env
  command "sudo ln -fs #{install_dir}/embedded/bin/serverspec-init #{install_dir}/bin/serverspec-init", :env => env
end