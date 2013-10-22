# nova
class {"nova":
    rabbit_host        => $::rabbit_host,
    sql_connection     => $::nova_db,
    verbose            => true,
    glance_api_servers => "$::glance_host:9292",
}

class {"nova::network::neutron":
  neutron_url               => "http://${::neutron_host}:9696",
  neutron_admin_password    => "$::neutron_service_password",
  neutron_admin_tenant_name => "service",
  neutron_region_name       => "regionOne",
  neutron_admin_auth_url    => "http://${::keystone_host}:35357/v2.0",
}

# Todo : remove this if moving to qpid
# seems to be needed in our mixture of rpm and pip packages
exec {"/usr/bin/pip install amqp":
  require => Class['nova'],
}

# Building seperate control and compute nodes still requires some nova
# baremetal configuration on the control node. Specifically, nova-api needs
# the nova_bm sql connection configured to talk to the nova_bm database when
# baremetal nodes are added.  Since building a control and compute node all in
# one would cause a puppet error with this defined twice, it's wrapped in a
# conditional that checks if the baremetal dnsmasq service does not exists.
if ! defined(File['/lib/systemd/system/nova-bm-dnsmasq.service']) {
  nova_config {
    'baremetal/sql_connection':   value => "$::nova_baremetal_db";
  }
}
