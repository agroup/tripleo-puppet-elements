
package {"python-cinderclient":
    before => Class["glance::api"]
}

class {"glance::api":
    auth_host => "$::keystone_host",
    keystone_tenant => "service",
    keystone_user => "glance",
    keystone_password => "unset",
    pipeline => 'keystone',
    sql_connection => $::glance_db
}

class { 'glance::backend::file': }

class {"glance::registry":
    auth_host => "$::keystone_host",
    keystone_tenant => "service",
    keystone_user => "glance",
    keystone_password => "unset",
    sql_connection => $::glance_db,
}

