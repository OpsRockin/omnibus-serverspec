cache_dir              './local/omnibus/cache'
git_cache_dir './local/omnibus/cache/install_path'
source_dir             './local/omnibus/src'
build_dir              './local/omnibus/build'
package_dir            './local/omnibus/pkg'
package_tmp            './local/omnibus/pkg-tmp'
append_timestamp false

if ENV['AWS_ACCESS_KEY_ID'] and ENV['AWS_SECRET_ACCESS_KEY'] and ENV['S3_BUCKET']
  s3_access_key ENV['AWS_ACCESS_KEY_ID']
  s3_secret_key ENV['AWS_SECRET_ACCESS_KEY']
  s3_bucket ENV['S3_BUCKET']
  use_s3_caching true
  publish_s3_access_key ENV['AWS_ACCESS_KEY_ID']
  publish_s3_secret_key ENV['AWS_SECRET_ACCESS_KEY']
end
# solaris_compiler "gcc"
# build_retries 3
