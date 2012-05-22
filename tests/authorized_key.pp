include ssh::server

ssh::authorized_key {
  'demo_access':
    ensure => present,
    user   => 'demo',
    type   => 'rsa',
    key    => '<key_data>';
}

