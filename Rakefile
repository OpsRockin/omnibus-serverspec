require 'yaml'
require 'json'
require 'open-uri'


task :default do
  s_versions = JSON.parse(open('https://rubygems.org/api/v1/versions/serverspec.json').read)
  s_versions.select! {|r| r.has_key?('number')}
  s_versions.select! {|r| r['number'].match(/^[\d]+\.[\d]+\.[\d]+$/)}

  si_versions = JSON.parse(open('https://rubygems.org/api/v1/versions/specinfra.json').read)
  si_versions.select! {|r| r.has_key?('number')}
  si_versions.select! {|r| r['number'].match(/^[\d]+\.[\d]+\.[\d]+$/)}

  i_versions = JSON.parse(open('https://rubygems.org/api/v1/versions/infrataster.json').read)
  i_versions.select! {|r| r.has_key?('number')}
  i_versions.select! {|r| r['number'].match(/^[\d]+\.[\d]+\.[\d]+$/)}

  d_versions = JSON.parse(open('https://rubygems.org/api/v1/versions/docker-api.json').read)
  d_versions.select! {|r| r.has_key?('number')}
  d_versions.select! {|r| r['number'].match(/^[\d]+\.[\d]+\.[\d]+$/)}

  w_versions = JSON.parse(open('https://rubygems.org/api/v1/versions/winrm.json').read)
  w_versions.select! {|r| r.has_key?('number')}
  w_versions.select! {|r| r['number'].match(/^[\d]+\.[\d]+\.[\d]+$/)}

  build_version  =  s_versions.first['number']
  si_build_version  =  si_versions.first['number']
  i_build_version  =  i_versions.first['number']
  d_build_version  =  d_versions.first['number']
  w_build_version  =  w_versions.first['number']
  vers = Hash.new
  vers = {
    serverspec: build_version,
    specinfra: si_build_version,
    infrataster: i_build_version,
    docker_api: d_build_version,
    winrm: w_build_version
  }
  puts JSON.pretty_generate vers
end

task :release_to_packagecloud, 'branch', 'dist', 'type'
task :release_to_packagecloud do |t, args|
  case args['branch']
  when 'master'
    reponame = 'serverspec'
  else
    reponame = 'dummy_with_ci'
  end

  raise unless system "bundle exec package_cloud push omnibus-serverspec/#{reponame}/#{args['dist']} pkg/*.#{args['type']}"
  end
end

task :yank_oldest_release, 'branch', 'dist'
task :yank_oldest_release do |t, args|
  oldest = get_oldest_pkg(args)
  unless oldest.empty?
    if args['branch'] == 'master'
      system "bundle exec package_cloud yank omnibus-serverspec/serverspec/#{args['dist']} #{oldest['filename']}"
    else
      system "bundle exec package_cloud yank omnibus-serverspec/dummy_with_ci/#{args['dist']} #{oldest['filename']}"
    end
  end
end


def get_oldest_pkg(args)
  case args['branch']
  when 'master'
    reponame = 'serverspec'
  else
    reponame = 'dummy_with_ci'
  end
  if args['branch'] == 'master'
  else
    target_pkgs = JSON.parse(open(
      "https://packagecloud.io/api/v1/repos/omnibus-serverspec/#{reponame}/packages.json",
      {:http_basic_authentication => [ENV['PACKAGECLOUD_TOKEN'], ""]}
    ).read).select {|pkg|
      pkg['distro_version'] == args['dist']
    }
    (target_pkgs.sort {|a,b| Time.parse(a['created_at']) <=> Time.parse(b['created_at']) }).first
  end
end

