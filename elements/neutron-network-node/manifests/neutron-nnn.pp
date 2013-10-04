# neutron-nnn.pp
#class {'neutron::agents::dhcp':
#}

class {'neutron::agents::l3':
}

class {'neutron::agents::dhcp':
}

class {'neutron::agents::metadata':
  auth_password => "$::neutron_service_password",
  shared_secret => "",
  auth_tenant    => 'service',
  auth_user      => 'neutron',
  auth_region    => 'regionOne',
}


#package{'iputils':}

