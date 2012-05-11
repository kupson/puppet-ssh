class ssh::client {
    include ssh::params

    package {
        $ssh::params::package_client:
            ensure => latest;
    }

    file {
        $ssh::params::path_ssh_known_hosts:
            ensure => file,
            mode   => 0644,
            owner  => "root",
            group  => "root";
    }

    resources {
        "sshkey": purge => true;
    }

    Sshkey <<| tag == "for-env-${::environment}" |>> {
        ensure => present,
    }

}

class ssh::client::allenv inherits ssh::client {
    
    Sshkey <<| |>> {
        ensure => present,
    }

}
