# Define: ssh::authorized_key
#
# Wrapper for ssh_authorized_key resource customized to ssh module.
#
# Parameters:
# 
#   [*ensure*]      - *present*|absent
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# include ssh::server
#
# ssh::authorized_key {
#   'demo_access':
#     ensure => present,
#     user   => 'demo',
#     type   => 'rsa',
#     key    => '<key_data>';
# }
#
define ssh::authorized_key (
    $ensure = 'present',
    $user,
    $type   = 'rsa',
    $key
) {

    $target = "${ssh::params::path_authorized_keys}/${user}"

    # How to do it without defined(), custom provider maybe?
    # It needs to run only once for a user.
    if !defined(File[$target]) {
        file {
            $target:
                ensure => 'file',
                owner  => 'root',
                group  => $user,
                mode   => '0640';
        }
    }

    ssh_authorized_key {
        $title:
            ensure  => $ensure,
            user    => 'root',
            target  => $target,
            type    => $type,
            key     => $key,
            notify  => File[$target];
    }

}
