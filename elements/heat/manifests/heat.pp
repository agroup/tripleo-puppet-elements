class {"heat":
    keystone_tenant => "$::heat_admin_tenant_name",
    keystone_user => "$::heat_admin_user",
    keystone_password => "$::heat_admin_password",
}

class {"heat::db":
    sql_connection => $::heat_db,
}