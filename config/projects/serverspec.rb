name "serverspec"
maintainer "HiganWorks LLC"
homepage "higanworks.com"

replaces        "serverspec"
install_path    "/opt/serverspec"
build_version   '1.0.0'
build_iteration 1

# creates required build directories
dependency "preparation"

# serverspec dependencies/components
dependency "serverspec"

# version manifest file
dependency "version-manifest"

exclude "\.git*"
exclude "bundler\/git"
