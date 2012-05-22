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

### ssh::authorized_key
Wrapper for ssh_authorized_key type. Put key into `/etc/ssh/authorized_keys` with proper permissions.

    include ssh::server

    ssh::authorized_key {
      'demo_access':
        ensure => present,
        user   => 'demo',
        type   => 'rsa',
        key    => '<key_data>';
    }

## ssh::params notes
Provide system dependent variables for other classes in this module.

- Debian (tested on squeeze)
- Ubuntu (untested, should work)

