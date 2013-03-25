class dough::farmer {
  package { "dough-farmer":
    ensure => present,
    } 
    service {"dough-farmer":
        ensure  => present,
        require => Package['dough-farmer']
    }
 }
