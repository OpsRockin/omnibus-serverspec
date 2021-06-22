serverspec Omnibus project
==========================

![example workflow](https://github.com/OpsRockin/omnibus-serverspec/actions/workflows/release.yml/badge.svg)


RPM and DEV packages are privided by [Github Releases](https://github.com/OpsRockin/omnibus-serverspec/releases).

## Description

This project creates full-stack platform-specific packages for
[serverspec](http://serverspec.org/ "serverspec - Home")!

Now, omnibus-serverspec building step is dockernized.

- <del>https://github.com/OpsRockin/omnibus_base_ubuntu14</del>
- https://github.com/OpsRockin/omnibus_base_ubuntu16
- https://github.com/OpsRockin/omnibus_base_ubuntu18
- <del>https://github.com/OpsRockin/omnibus_base_centos6</del>
- https://github.com/OpsRockin/omnibus_base_centos7
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

