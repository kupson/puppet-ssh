class ssh::server {
    include ssh::params

    package {
        $ssh::params::package_server:
            ensure => latest;
    }

    service {
        $ssh::params::service_name:
            ensure     => running,
            enable     => true,
            hasrestart => true,
            hasstatus  => true,
            require    => Package[$ssh::params::package_server];
    }

    file {
        $ssh::params::path_authorized_keys:
            ensure  => directory,
            owner   => 'root',
            group   => 'root',
            mode    => 0711,
            require => Package[$ssh::params::package_server];
    }

    augeas {
        'sshd_settings':
            lens    => 'Sshd.lns',
            context => "/files${ssh::params::path_sshd_config}",
            incl    => $ssh::params::path_sshd_config,
            notify  => Service[$ssh::params::service_name],
            changes => [
                         'set Protocol 2',
                         'set AddressFamily inet',
                         'set LogLevel VERBOSE',
                         'set UsePrivilegeSeparation yes',
                         'set PermitEmptyPasswords no',
                         'set PermitRootLogin without-password',
                         'set PubkeyAuthentication yes',
                         'set ChallengeResponseAuthentication no',
                         'set PasswordAuthentication no',
                         'set Subsystem/sftp internal-sftp',
                         "set AuthorizedKeysFile ${ssh::params::path_authorized_keys}/%u",
                       ];
    }
}
