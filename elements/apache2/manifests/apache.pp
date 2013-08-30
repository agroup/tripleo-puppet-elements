
class { 'apache':
	default_ssl_vhost => true,
}

exec { "debian-make-ssl":
    command => "make-ssl-cert generate-default-snakeoil --force-overwrite",
    path => "/usr/bin:/usr/sbin:/bin",
    onlyif => [
                "test -f /etc/debian_version",
                "test `openssl x509 -noout -in /etc/ssl/certs/ssl-cert-snakeoil.pem; echo $?` != 0"
              ]
}
