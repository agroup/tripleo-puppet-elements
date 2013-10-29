# horizon
class {'openstack::horizon':
    secret_key => 'unset',
    django_debug => true
}
