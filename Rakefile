require 'yaml'
require 'json'
require 'open-uri'

platforms = Dir.glob('.kitchen/*.yml')
@instances = []
platforms.each do |platform|
  @instances << YAML.load(File.read(platform))
end

s_versions = JSON.parse(open('https://rubygems.org/api/v1/versions/serverspec.json').read)
s_versions.select! {|r| r.has_key?('number')}
s_versions.select! {|r| r['number'].match(/^[\d]+\.[\d]+\.[\d]+$/)}

i_versions = JSON.parse(open('https://rubygems.org/api/v1/versions/infrataster.json').read)
i_versions.select! {|r| r.has_key?('number')}
i_versions.select! {|r| r['number'].match(/^[\d]+\.[\d]+\.[\d]+$/)}

build_version  =  s_versions.first['number']
i_build_version  =  i_versions.first['number']

task :default do
  vers = Hash.new
  vers = {
    serverspec: build_version,
    infrataster: i_build_version
  }
  puts JSON.pretty_generate vers
end

desc "collect packages from remote server"
task :sync do
  # puts @instances
  remote_user = ENV['REMOTE_USER_NAME'] || 'root'
  @instances.each do |instance|
    system "rsync -avz --progress -e 'ssh -oStrictHostKeyChecking=no -C -i #{ENV['DO_SSH_KEY']}' #{remote_user}@#{instance['hostname']}:/home/vagrant/serverspec/pkg/ ./pkg"
  end
end

task :release do
#  debpkg = Dir.glob('pkg/*.deb').sort.first
#  if debpkg.include?(build_version)
#    system "omnibus release package #{debpkg} --public"
#  end if debpkg
#
#  rpmpkg = Dir.glob('pkg/*.rpm').sort.first
#  if rpmpkg.include?(build_version)
#    system "omnibus release package #{rpmpkg} --public"
#  end if rpmpkg
end
