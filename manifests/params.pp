class ssh::params {

    case $::operatingsystem {
        'ubuntu', 'debian': {
            $package_client       = 'openssh-client'
            $package_server       = 'openssh-server'
            $service_name         = 'ssh'
            $path_ssh_known_hosts = '/etc/ssh/ssh_known_hosts'
        }
        default: {
            fail("Unsupported platform: ${::operatingsystem}")
        }
    }

}
