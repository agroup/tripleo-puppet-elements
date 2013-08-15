
# nova-api

class {"nova::api":
  admin_tenant_name => "service",
  admin_user        => 'nova',
  admin_password    => "$::service_password",
  enabled           => $enabled,
  sync_db           => $enabled,
}

class {"nova::network::neutron":
  neutron_admin_password    => "$::service_password",
  neutron_admin_tenant_name => "service",
  neutron_region_name       => "regionOne",
}

class cinder::client(
  $package_ensure = 'present'
) {
  package { 'python-cinderclient': }
}

class {["nova::cert", "nova::conductor", "nova::scheduler"]: # and consoleauth?
  enabled           => $enabled,
}

