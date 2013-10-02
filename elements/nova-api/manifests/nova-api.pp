
# nova-api

class {"nova::api":
  admin_tenant_name => "service",
  admin_user        => 'nova',
  admin_password    => "$::nova_service_password",
  enabled           => $enabled,
  sync_db           => $enabled,
}

class cinder::client(
  $package_ensure = 'present'
) {
  package { 'python-cinderclient': }
}

class {["nova::cert", "nova::conductor", "nova::scheduler"]: # and consoleauth?
  enabled           => $enabled,
}

# This is needed here only so that reset-db can call nova-baremetal-manage on
# the overcloud notcompute node and should eventually be removed. The version
# is also included in the package name so it doesn't clash with modules that
# already install it. reset-db should be fixed so nova-baremetal-manage isn't
# needed on the overcloud
package{'openstack-nova-compute-2013.2':
    ensure => "present"
}

# nova-compute depends on vibvirt (dep prossibly should be removed), libvirts default net messes up with net access through seed vm
if ( $enabled == true){
  exec {"rm-libvirt-net":
    path    => ['/sbin'],
    command => 'ip address del 192.168.122.1/24 dev virbr0',
    returns => [0,1,2],
  }
}
