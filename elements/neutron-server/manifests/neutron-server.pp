# neutron-server.pp

class {'neutron::server':
  auth_host => "$::keystone_host",
  auth_tenant => "service",
  auth_user => "neutron",
  auth_password => "$::service_password",
}

class {'neutron::plugins::ovs':
  sql_connection      => "$::neutron_ovs_db",
  tenant_network_type => "$::neutron_ovs_tenant_network_type",
  network_vlan_ranges => "$::neutron_ovs_network_vlan_ranges",
}

