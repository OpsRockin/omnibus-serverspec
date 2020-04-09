serverspec Omnibus project
==========================

[![CircleCI](https://circleci.com/gh/OpsRockin/omnibus-serverspec/tree/master.svg?style=svg)](https://circleci.com/gh/OpsRockin/omnibus-serverspec/tree/master)

## Packages

### Bintray

[Bintray](https://bintray.com/omnibus-serverspec)

- RPM: [ ![Download](https://api.bintray.com/packages/omnibus-serverspec/rpm/omnibus-serverspec/images/download.svg) ](https://bintray.com/omnibus-serverspec/rpm/omnibus-serverspec/_latestVersion)
    - Conpatible all rpm-based system. (Such as redhat, centos 6/7/8, etc...)
- DEB: [ ![Download](https://api.bintray.com/packages/omnibus-serverspec/deb/omnibus-serverspec/images/download.svg) ](https://bintray.com/omnibus-serverspec/deb/omnibus-serverspec/_latestVersion)
    - Conpatible all apt-based system.


### PackageCloud

- Note: bandwidth limit 15GB

[![Package repository](https://img.shields.io/badge/install%20via-packagecloud.io-green.svg?style=flat-square)](https://packagecloud.io/omnibus-serverspec/serverspec)


## Description

This project creates full-stack platform-specific packages for
[serverspec](http://serverspec.org/ "serverspec - Home")!

Now, omnibus-serverspec building step is dockernized.

- <del>https://github.com/OpsRockin/omnibus_base_ubuntu14</del>
- https://github.com/OpsRockin/omnibus_base_ubuntu16
- https://github.com/OpsRockin/omnibus_base_ubuntu18
- https://github.com/OpsRockin/omnibus_base_centos6
- https://github.com/OpsRockin/omnibus_base_centos8


## Build for Developers

Kitchen-based Build Environment
-------------------------------

Prepare VMs.

```shell
$ bundle exec librarian-chef install
$ bundle exec kitchen converge
```

Then login to the instance and build the project as described in the Usage
section:

You should clone project files when loggd in to VM to avoid conflict bundled environment.

```shell with login
$ bundle exec kitchen login ubuntu(or centos)
[vagrant@ubuntu...] $ git clone serverspec vm
[vagrant@ubuntu...] $ cd vm
[vagrant@ubuntu...] $ source /home/omnibus/load-omnibus-toolchain.sh
[vagrant@ubuntu...] $ bundle install --binstubs
[vagrant@ubuntu...] $ ./bin/omnibus build serverspec
```


### Destroy your VMs

```
$ bundle exec kitchen destroy
```

