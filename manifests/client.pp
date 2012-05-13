# Class: ssh::client
#
# This module install ssh client and import all keys from same environment.
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
#   include ssh::client
#
class ssh::client {
    include ssh::params

    package {
        $ssh::params::package_client:
            ensure => latest;
    }

    file {
        $ssh::params::path_ssh_known_hosts:
            ensure => file,
            mode   => '0644',
            owner  => 'root',
            group  => 'root';
    }

    resources {
        'sshkey': purge => true;
    }

    sshkey {
         'localhost':
            type         => 'ssh-rsa',
            key          => $::sshrsakey,
            host_aliases => '127.0.0.1';
    }

    Sshkey <<| tag == "for-env-${::environment}" |>> {
        ensure => present,
    }

}
