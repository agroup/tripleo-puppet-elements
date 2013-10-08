class {"heat":
    keystone_tenant => "service",
    keystone_user => "heat",
    keystone_password => "$::service_password",
}

class {"heat::db":
    sql_connection => $::heat_db,
}