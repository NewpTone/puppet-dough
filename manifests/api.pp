class dough::api(
    $auth_host          = '127.0.0.1',
    $admin_tenant_name  = 'services',
    $admin_user         = 'dough',
    $admin_password     = 'dough',
    )
 {
     package { "dough-api":
        ensure => present,
            } 
     file {"/etc/dough/api-paste.ini":
        content => template('dough/api-paste.ini.erb'),
        require => Package['dough-api'],
        }
     service {"dough-api-server":
        ensure  => present,
        require => Package['dough-api']
        }
}
