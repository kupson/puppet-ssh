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
            hasstatus  => true;
    }

}
