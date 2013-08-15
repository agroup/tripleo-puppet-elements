# nova-baremetal

nova_config {
  'DEFAULT/host':   value => 'ubuntu'; # this is the name of the host tripleo registers them as
  'DEFAULT/compute_driver':   value => 'nova.virt.baremetal.driver.BareMetalDriver';
  'DEFAULT/scheduler_host_manager':   value => "nova.scheduler.baremetal_host_manager.BaremetalHostManager";
  'baremetal/sql_connection':   value => "$::nova_baremetal_db";
  'baremetal/net_config_template':   value => "/usr/lib/python2.7/site-packages/nova/virt/baremetal/net-static.ubuntu.template";
  'baremetal/tftp_root':   value => "/tftpboot";
  'baremetal/instance_type_extra_specs':   value => "cpu_arch:$::nova_baremetal_arch";
  'baremetal/driver':   value => "nova.virt.baremetal.pxe.PXE";
  'baremetal/pxe_network_config':   value => "True";
  'baremetal/pxe_deploy_timeout':   value => "$::nova_baremetal_pxe_deploy_timeout";
  'baremetal/power_manager':   value => "$::nova_baremetal_power_manager";
}
if ( "$::nova_baremetal_virtual_power" == "1" ){
  nova_config {
    'baremetal/virtual_power_host_user':   value => "$::nova_baremetal_virtual_power_user";
    'baremetal/virtual_power_host_key':   value => "$::nova_baremetal_virtual_power_key";
    'baremetal/virtual_power_ssh_host':   value => "$::nova_baremetal_virtual_power_ssh_host";
    'baremetal/virtual_power_type':   value => "$::nova_baremetal_virtual_power_type";
  }
}

# TODO : some of this should be packaged
package{'syslinux':}
 
file{['/tftpboot', '/tftpboot/pxelinux.cfg']:
  ensure => 'directory',
  notify => File['/tftpboot/pxelinux.0'],
  owner   => 'nova',
}
file{'/tftpboot/pxelinux.0':
  ensure => 'link',
  target => '/usr/share/syslinux/pxelinux.0',
}

file{'/lib/systemd/system/nova-bm-dnsmasq.service':
  content => '[Unit]
Description=Nova dnsmasq service
After=openvswitch.service

[Service]  
Type=forking  
ExecStartPre=/bin/mkdir -p /tftpboot
ExecStartPre=/bin/chown -R nova:nova /tftpboot
ExecStartPre=-/bin/killall -9 dnsmasq
ExecStart=/sbin/dnsmasq --conf-file= --port=0 --enable-tftp --tftp-root=/tftpboot --dhcp-boot=pxelinux.0 --bind-interfaces \
                        --pid-file=/var/run/dnsmasq.pid --interface=br-ctlplane --dhcp-range=192.0.2.65,192.0.2.69,29

[Install]
WantedBy=multi-user.target
Alias=nova-bm-dnsmasq.service',
}

service {'nova-bm-dnsmasq':
  subscribe => Exec['post-nova_config'],
  ensure => 'running',
}

exec {"ssh-key":
  path    => ['/usr/bin'],
  command => 'ssh-keygen -t rsa -f /opt/stack/boot-stack/virtual-power-key -N "" -C "boot-stack key for use with nova VirtualPowerDriver"',
  creates => '/opt/stack/boot-stack/virtual-power-key',
  require => Class['nova'],
}

exec{"keyowner":
  path    => ['/usr/bin'],
  command => 'chown nova /opt/stack/boot-stack/virtual-power-key',
  subscribe => Exec['ssh-key'],
}

file{'/lib/systemd/system/nova-baremetal-deploy-helper.service':
  content => '[Unit]
Description=Nova baremetal deploy helper

[Service]
Type=simple
ExecStart=/usr/bin/nova-baremetal-deploy-helper

[Install]
WantedBy=multi-user.target',
}

service {'nova-baremetal-deploy-helper':
  subscribe => Exec['post-nova_config'],
  ensure => 'running',
}
