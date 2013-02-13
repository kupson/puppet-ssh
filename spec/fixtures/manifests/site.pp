node 'localhost.localdomain' { 
    include ssh
    include ssh::client::allenv

    user {
        'thedummyuser':
            ensure => present;
    }

    ssh_authorized_key {
        'root@localhost.localdomain':
            key      => 'AAAA',
            type     => 'rsa',
            user     => 'root',
            provider => 'parsed_systemdir',
            require  => User['thedummyuser'];
    }  

    ssh_authorized_key {
        'thedummyuser@localhost.localdomain':
            key      => 'AAAA',
            type     => 'rsa',
            user     => 'root',
            provider => 'parsed_systemdir',
            require  => User['thedummyuser'];
    }  
}
