serverspec Omnibus project
==========================

[![Circle CI](https://circleci.com/gh/OpsRockin/omnibus-serverspec.svg?style=svg)](https://circleci.com/gh/OpsRockin/omnibus-serverspec)
[![Package repository](https://img.shields.io/badge/install%20via-packagecloud.io-green.svg?style=flat-square)](https://packagecloud.io/omnibus-serverspec/serverspec)

[Bintray](https://bintray.com/omnibus-serverspec)

This project creates full-stack platform-specific packages for
[serverspec](http://serverspec.org/ "serverspec - Home")!

Now, omnibus-serverspec building step is dockernized.

- https://github.com/OpsRockin/omnibus_base_ubuntu14
- https://github.com/OpsRockin/omnibus_base_centos6


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

