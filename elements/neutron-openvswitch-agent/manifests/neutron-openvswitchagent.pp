# neutron-openvswitchagent.pp 

class { 'neutron::agents::ovs':
  local_ip         => "127.0.0.1", # "$::neutron_ovs_local_ip",
  enable_tunneling => "$::neutron_ovs_enable_tunneling",
  bridge_mappings  => ["$::neutron_ovs_bridge_mappings"],
}

#neutron_plugin_ovs {
#  'DATABASE/sql_connection': value => "$::neutron_ovs_db";
#  'OVS/tenant_network_type': value => "$::neutron_ovs_tenant_network_type";
#  'OVS/network_vlan_ranges': value => "$::neutron_ovs_network_vlan_ranges";
#}

#exec{"init-neutron-ovs":
#  path   => ['/usr/bin', '/usr/sbin', '/usr/local/bin'],
#  before => Class['neutron'],
#}

