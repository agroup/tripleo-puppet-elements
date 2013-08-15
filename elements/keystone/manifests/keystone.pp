
class {'keystone':
    admin_token => "$::admin_token",
    sql_connection => $::keystone_db,
    enabled => $enabled,
}

