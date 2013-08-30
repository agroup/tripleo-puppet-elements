# neutron.pp
class {'neutron':
  rabbit_password => "$::rabbit_password",
  rabbit_host => "$::rabbit_host",
}

