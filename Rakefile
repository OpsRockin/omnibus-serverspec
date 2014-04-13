require 'yaml'

platforms = Dir.glob('.kitchen/*.yml')
@instances = []
platforms.each do |platform|
  @instances << YAML.load(File.read(platform))
end

task :default do
  puts @instances
  @instances.each do |instance|
    system "rsync -avz #{instance['hostname']}:serverspec/pkg/ ./pkg"
  end
end

task :release do
  debpkg = Dir.glob('pkg/*.deb').sort.first
  system "omnibus release package #{debpkg} --public"
  rpmpkg = Dir.glob('pkg/*.rpm').sort.first
  system "omnibus release package #{rpmpkg} --public"
end
