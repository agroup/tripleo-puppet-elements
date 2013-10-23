# nova-baremetal-db

nova_config {
  'baremetal/sql_connection':   value => "$::nova_baremetal_db";
}
