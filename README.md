serverspec Omnibus project
==========================

[![Circle CI](https://circleci.com/gh/OpsRockin/omnibus-serverspec.svg?style=svg)](https://circleci.com/gh/OpsRockin/omnibus-serverspec)
[![Package repository](https://img.shields.io/badge/install%20via-packagecloud.io-green.svg?style=flat-square)](https://packagecloud.io/omnibus-serverspec/serverspec)

This project creates full-stack platform-specific packages for
[serverspec](http://serverspec.org/ "serverspec - Home")!

## Setup

```
$ vagrant plugin install vagrant-omnibus
$ bundle
```

## Build

Kitchen-based Build Environment
-------------------------------
Every Omnibus project ships will a project-specific
[Berksfile](http://berkshelf.com/) and [Vagrantfile](http://www.vagrantup.com/)
that will allow you to build your omnibus projects on all of the projects listed
in the `.kitchen.yml`. You can add/remove additional platforms as needed by
changing the list found in the `.kitchen.yml` `platforms` YAML stanza.

This build environment is designed to get you up-and-running quickly. However,
there is nothing that restricts you to building on other platforms. Simply use
the [omnibus cookbook](https://github.com/opscode-cookbooks/omnibus) to setup
your desired platform and execute the build steps listed above.

The default build environment requires Test Kitchen and VirtualBox for local
development. Test Kitchen also exposes the ability to provision instances using
various cloud providers like AWS, DigitalOcean, or OpenStack. For more
information, please see the [Test Kitchen documentation](http://kitchen.ci).

Once you have tweaked your `.kitchen.yml` (or `.kitchen.local.yml`) to your
liking, you can bring up an individual build environment using the `kitchen`
command.

```shell
$ bundle exec kitchen converge ubuntu-12.04
```

Then login to the instance and build the project as described in the Usage
section:

```shell
$ bundle exec kitchen login ubuntu-12.04
[vagrant@ubuntu...] $ cd serverspec
[vagrant@ubuntu...] $ bundle install
[vagrant@ubuntu...] $ ...
[vagrant@ubuntu...] $ ./bin/omnibus build project serverspec
```

For a complete list of all commands and platforms, run `kitchen list` or
`kitchen help`.


## Release to s3

Copy `omnibus.rb.example` to `omnibus.rb` and fill it.

```shell
omnibus release package PATH  [ --public]  # Upload a single package to S3
```

Package Examples: https://s3.amazonaws.com/omnibus-serverspec/
