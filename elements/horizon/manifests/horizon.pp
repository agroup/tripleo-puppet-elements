# horizon
class {'horizon':
    secret_key => file('/tmp/horizon-secret-key'),
    fqdn => '*'
}

