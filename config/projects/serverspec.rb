
name "serverspec"
maintainer "CHANGE ME"
homepage "CHANGEME.com"

replaces        "serverspec"
install_path    "/opt/serverspec"
build_version   '0.14.1-01'
build_iteration 1

# creates required build directories
dependency "preparation"

# serverspec dependencies/components
dependency "serverspec"

# version manifest file
dependency "version-manifest"

exclude "\.git*"
exclude "bundler\/git"