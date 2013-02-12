# travis-ci build status
[![Build Status](https://travis-ci.org/rtucker-mozilla/puppet-ssh-1.png)](https://travis-ci.org/rtucker-mozilla/puppet-ssh-1)

# Ssh module for Puppet

## Description
This module installs and configures ssh client/server.

Some features:

- export/import ssh host keys based on `$environment` Puppet variable
- only root can manage ssh_authorized_keys for users (`/etc/ssh/authorized_keys/<username>`)
- purges unknown sshkey resources

Sshd configuration:

- only protocol 2
- only IPv4
- internal sftp subsystem
- disable password authorization
- only PubKey auth (root account too)

## Usage

### ssh
Install ssh client and server.

    include ssh

### ssh::client
Install ssh client and export host key for current `$environment`.
Add 'localhost' key to known hosts.

    include ssh::client

### ssh::client::allenv
Class ssh::client modified to import ssh host keys from all environments.
Suitable for puppet master host or other all-environment nodes.

    include ssh::client::allenv

### ssh::server
This module install ssh server and configure it as mentioned in module description.
Host key is exported with `for-env-${environment}` tag.

    include ssh::server

## ssh::params notes
Provide system dependent variables for other classes in this module.

- Debian (tested on squeeze)
- Ubuntu (untested, should work)

## Providers

### ssh_authorized_key (parsed_systemdir)
New provider for ssh_authorized_key type that put authorized_keys files with
proper permissions in `/etc/ssh/authorized_keys` directory.

    File mode and ownership example:
    -rw-r----- 1 root demo  595 May 24 20:34 /etc/ssh/authorized_keys/demo

