
class {"cinder":
	sql_connection	=> "$::cinder_db",
  	rabbit_password	=> "$::rabbit_password",
    	rabbit_host     => "$::rabbit_host",
	debug          	=> true,
    	verbose		=> true,
}

class { 'cinder::api':
	keystone_auth_host => "$::keystone_host",
	keystone_user => "cinder",
	keystone_password => "$::cinder_service_password",
	enabled => $enabled,
}

class { 'cinder::volume': }

class { 'cinder::scheduler': }

# Needed on debian based distros
file{'/etc/default/iscsitarget':
  content => 'ISCSITARGET_ENABLE=true',
}
