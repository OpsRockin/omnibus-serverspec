require 'yaml'
require 'json'
require 'open-uri'

desc "create versions.json"
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

namespace :packagecloud do
  desc "release to packagecloud"
  task :release, 'branch', 'dist', 'type'
  task :release do |t, args|
    case args['branch']
    when 'master'
      reponame = 'serverspec'
    else
      reponame = 'dummy_with_ci'
    end

    raise unless system "bundle exec package_cloud push omnibus-serverspec/#{reponame}/#{args['dist']} pkg/*.#{args['type']}"
  end

  desc "yank from packagecloud"
  task :yank_oldest, 'branch', 'dist'
  task :yank_oldest do |t, args|
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
      gen = 3
    else
      reponame = 'dummy_with_ci'
      gen = 1
    end

    target_pkgs = JSON.parse(open(
      "https://packagecloud.io/api/v1/repos/omnibus-serverspec/#{reponame}/packages.json",
      {:http_basic_authentication => [ENV['PACKAGECLOUD_TOKEN'], ""]}
    ).read).select {|pkg|
      pkg['distro_version'] == args['dist']
    }

    return [] if target_pkgs.length <= gen

    (target_pkgs.sort {|a,b| Time.parse(a['created_at']) <=> Time.parse(b['created_at']) }).first
  end
end

namespace :bintray do
  versions = JSON.parse(File.read("pkg/version-manifest.json"))
  desc "release to bintray"
  task :release do
    system %Q{jfrog bt vc --desc="#{bintray_description(versions['software'])}" --user=omnibus-serverspec-gh -key=#{ENV['BINTRAY_APIKEY']} omnibus-serverspec/rpm/omnibus-serverspec/#{versions['build_version']}-#{ENV['CIRCLE_BUILD_NUM']}}
    system %Q{jfrog bt u --user=omnibus-serverspec-gh -key=#{ENV['BINTRAY_APIKEY']} --override=true --publish=true pkg/serverspec-*.rpm omnibus-serverspec/rpm/omnibus-serverspec/#{versions['build_version']}-#{ENV['CIRCLE_BUILD_NUM']} }
    system %Q{jfrog bt vc --desc="#{bintray_description(versions['software'])}" --user=omnibus-serverspec-gh -key=#{ENV['BINTRAY_APIKEY']} omnibus-serverspec/deb/omnibus-serverspec/#{versions['build_version']}-#{ENV['CIRCLE_BUILD_NUM']}}
    system %Q{jfrog bt u --user=omnibus-serverspec-gh -key=#{ENV['BINTRAY_APIKEY']} --override=true --publish=true --deb=xenial/main/amd64 pkg/serverspec_*.deb omnibus-serverspec/deb/omnibus-serverspec/#{versions['build_version']}-#{ENV['CIRCLE_BUILD_NUM']} }
  end

  desc "yank from bintray"
  task :yank_oldest do
    rpms = bt_rpm_versions
    if rpms.length > 3
      system %Q{jfrog bt vd --quiet=true --user=omnibus-serverspec-gh -key=#{ENV['BINTRAY_APIKEY']} omnibus-serverspec/rpm/omnibus-serverspec/#{rpms.sort.first}}
    end

    debs = bt_deb_versions
    if debs.length > 3
      system %Q{jfrog bt vd --quiet=true --user=omnibus-serverspec-gh -key=#{ENV['BINTRAY_APIKEY']} omnibus-serverspec/deb/omnibus-serverspec/#{debs.sort.first}}
    end
  end

  def bintray_description(software)
    "Serverspec #{software['serverspec']['locked_version']} and Specinfra #{software['specinfra']['locked_version']} with ruby #{software['ruby']['locked_version']}"
  end

  def bt_rpm_versions
    rpm_pkgs = `jfrog bt ps --user omnibus-serverspec-gh -key #{ENV['BINTRAY_APIKEY']} omnibus-serverspec/rpm/omnibus-serverspec`
    JSON.parse(rpm_pkgs.match(/{.+}/m)[0])['versions']
  end

  def bt_deb_versions
    deb_pkgs = `jfrog bt ps --user omnibus-serverspec-gh -key #{ENV['BINTRAY_APIKEY']} omnibus-serverspec/deb/omnibus-serverspec`
    JSON.parse(deb_pkgs.match(/{.+}/m)[0])['versions']
  end
end


