class dough::daemon {
    package {'dough-daemon':
        ensure => present,
            }
    service {'dough-daemon':
        ensure  => present,
        require => Package['dough-daemon']
    }
 }
