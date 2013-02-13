node default {
    puts 'loaded'
    include ssh::server
    user {'thedummyuser':
        ensure => present;
    }

}
