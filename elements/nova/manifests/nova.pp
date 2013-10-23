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
