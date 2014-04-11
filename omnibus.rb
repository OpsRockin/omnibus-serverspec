cache_dir              './local/omnibus/cache'
install_path_cache_dir './local/omnibus/cache/install_path'
source_dir             './local/omnibus/src'
build_dir              './local/omnibus/build'
package_dir            './local/omnibus/pkg'
package_tmp            './local/omnibus/pkg-tmp'

release_s3_access_key ENV['RELEASE_S3_ACCESS_KEY']
release_s3_secret_key ENV['RELEASE_S3_SECRET_KEY']
release_s3_bucket ENV['RELEASE_S3_BUCKET']
# use_s3_caching true
# solaris_compiler "gcc"
# build_retries 3
