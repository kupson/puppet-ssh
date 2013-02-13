# Class: ssh::params
#
# This class sets platform specific variables for ssh:: namespace.
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class ssh::params {
    if $::osfamily {
        case $::osfamily {
            'Debian': {
                $package_client       = 'openssh-client'
                $package_server       = 'openssh-server'
                $service_name         = 'ssh'
                $path_ssh_known_hosts = '/etc/ssh/ssh_known_hosts'
                $path_sshd_config     = '/etc/ssh/sshd_config'
                $path_authorized_keys = '/etc/ssh/authorized_keys'
            }
            'Redhat': {
                $package_client       = 'openssh-clients'
                $package_server       = 'openssh-server'
                $service_name         = 'sshd'
                $path_ssh_known_hosts = '/etc/ssh/ssh_known_hosts'
                $path_sshd_config     = '/etc/ssh/sshd_config'
                $path_authorized_keys = '/etc/ssh/authorized_keys'
            }
            default: {
                fail("Unsupported platform: ${::operatingsystem}")
            }
        }
    } else {
        case $::operatingsystem {
            'ubuntu', 'debian': {
                $package_client       = 'openssh-client'
                $package_server       = 'openssh-server'
                $service_name         = 'ssh'
                $path_ssh_known_hosts = '/etc/ssh/ssh_known_hosts'
                $path_sshd_config     = '/etc/ssh/sshd_config'
                $path_authorized_keys = '/etc/ssh/authorized_keys'
            }
            'centos', 'redhat': {
                $package_client       = 'openssh-clients'
                $package_server       = 'openssh-server'
                $service_name         = 'sshd'
                $path_ssh_known_hosts = '/etc/ssh/ssh_known_hosts'
                $path_sshd_config     = '/etc/ssh/sshd_config'
                $path_authorized_keys = '/etc/ssh/authorized_keys'
            }
            default: {
                fail("Unsupported platform: ${::operatingsystem}")
            }
        }
    }

}
