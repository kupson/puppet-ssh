class ssh::client::allenv inherits ssh::client {
    
    Sshkey <<| |>> {
        ensure => present,
    }

}

