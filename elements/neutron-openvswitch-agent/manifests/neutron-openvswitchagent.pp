# neutron-openvswitchagent.pp 

if $::neutron_ovs_bridge_mappings == undef{
    $bridge_mappings = []
}else{
    $bridge_mappings = [$::neutron_ovs_bridge_mappings]
}


class { 'neutron::agents::ovs':
  local_ip         => "$::neutron_ovs_local_ip",
  enable_tunneling => "$::neutron_ovs_enable_tunneling" ? {"False"=>false, default=>true} ,
  bridge_mappings  => $bridge_mappings,
}

# The neutron::plugins::ovs class populates these on the notcompute node
# so we need do do them here, only if its a compute node of the over cloud.
if ( "$::hostname" =~ /overcloud-novacompute/ ){
  neutron_plugin_ovs {
    'OVS/tenant_network_type': value => "$::neutron_ovs_tenant_network_type";
    'OVS/tunnel_id_ranges': value => "1:1000";
  }
}

#exec{"init-neutron-ovs":
#  path   => ['/usr/bin', '/usr/sbin', '/usr/local/bin'],
#  before => Class['neutron'],
#}

