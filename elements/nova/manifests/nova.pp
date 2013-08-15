# nova
class {"nova":
    sql_connection => $::nova_db,
    debug          => true,
    verbose        => true,
}

# Todo : remove this if moving to qpid
# seems to be needed in our mixture of rpm and pip packages
exec {"/usr/bin/pip install amqp":
  require => Class['nova'],
}

