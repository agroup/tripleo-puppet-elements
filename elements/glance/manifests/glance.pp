
package {"python-cinderclient":
    before => Class["glance::api"]
}

class {"glance::api":
    auth_host => "$::keystone_host",
    keystone_tenant => "service",
    keystone_user => "glance",
    keystone_password => "$::glance_service_password",
    pipeline => 'keystone',
    sql_connection => $::glance_db,
    enabled => $enabled,
}

class { 'glance::backend::file': }

class {"glance::registry":
    auth_host => "$::keystone_host",
    keystone_tenant => "service",
    keystone_user => "glance",
    keystone_password => "$::glance_service_password",
    sql_connection => $::glance_db,
    enabled => $enabled,
}

class { 'glance::notify::rabbitmq':
    rabbit_password => "$::rabbit_password",
    rabbit_host => "$::rabbit_host",
}
