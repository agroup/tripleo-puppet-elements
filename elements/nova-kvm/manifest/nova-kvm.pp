
# nova-kvm

if $::is_virtual == "true" {
    $libvirt_type = "qemu"
}else{
    $libvirt_type = "kvm"
}

class {"nova::compute":
    enabled => true,
}

package { 'qemu-kvm':
    ensure => present,
    before => Class['nova::compute::libvirt']
}

class { 'nova::compute::libvirt':
  libvirt_type                => "$libvirt_type",
}
