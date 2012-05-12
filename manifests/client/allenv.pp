# Class: ssh::allenv
#
# Class ssh::client modified to import ssh host keys from all environments.
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
#   include ssh::client::allenv
#
class ssh::client::allenv inherits ssh::client {
    
    Sshkey <<| |>> {
        ensure => present,
    }

}

