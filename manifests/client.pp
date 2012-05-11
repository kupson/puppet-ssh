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

}
