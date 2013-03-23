class dough::api(
    $auth_host          = '127.0.0.1',
    $admin_tenant_name  = 'services',
    $admin_user         = 'dough',
    $admin_password     = 'dough',
 {
  package { "dough-api":
    ensure => 'present',
  } 
}
