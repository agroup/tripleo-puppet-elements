
# nova-kvm

if $::is_virtual == "true" {
    $libvirt_type = "qemu"
}else{
    $libvirt_type = "kvm"
}

package { 'qemu-kvm':
    ensure => present,
    before => Class['nova::compute::libvirt']
}

class { 'nova::compute::libvirt':
  libvirt_type                => "$libvirt_type",
}


# Todo : remove this there seems to be a problem with the packages verison
# too old ?
exec {"/usr/bin/pip install --upgrade oslo.config":
  require => Class['nova'],
}

