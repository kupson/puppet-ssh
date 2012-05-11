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

    Augeas {
        lens    => 'Sshd.lns',
        context => "/files${ssh::params::path_sshd_config}",
        incl    => $ssh::params::path_sshd_config,
        notify  => Service[$ssh::params::service_name],
    }

    augeas {
        'sshd_protocol':      changes => 'set Protocol 2';
        'sshd_ipv4only':      changes => 'set AddressFamily inet';
        'sshd_root_login':    changes => 'set PermitRootLogin without-password';
        'sshd_privsep':       changes => 'set UsePrivilegeSeparation yes';
        'sshd_allow_pubkey':  changes => 'set PubkeyAuthentication yes';
        'sshd_deny_chresp':   changes => 'set ChallengeResponseAuthentication no';
        'sshd_deny_plain':    changes => 'set PasswordAuthentication no';
        'sshd_noempty_pass':  changes => 'set PermitEmptyPasswords no';
        'sshd_loglevel':      changes => 'set LogLevel VERBOSE';
        'sshd_internal_sftp':
            context => "/files${ssh::params::path_sshd_config}/Subsystem",
            changes => 'set sftp internal-sftp';
    }
}
