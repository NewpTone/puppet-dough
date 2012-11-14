class dough(
#Mysql nova db setting
	$nova_db_username		= 'nova',
	$nova_db_passwd			= 'nova',
	$nova_db_host			= '127.0.0.1',
	$nova_db_name			= 'nova',
	$dough_db_username		= 'dough',
	$dough_db_passwd		= 'dough',
	$dough_db_host			= '127.0.0.1',
	$dough_db_name			= 'dough',
	$sql_connection			= '',
	$nova_sql_connection	= '',
# Default setting
	$listen					= '0.0.0.0',
	$host					= '127.0.0.1',
	$region					= 'regionone',
	$dough_token			= 'admin',
	$memcache				= '127.0.0.1:11211',
	$keystone_username		= 'keystone',
	$keystone_password		= 'keystone',
	$keystone_tenant_name	= 'keystone_teanant',
	$keystone_auth_url		= 'keystone_auth_url',
	$purchases_buffer		= 'purchases_buffer',
	$migrate_url			= 'mysql://root:nova@localhost/',
	$migrate_databases		= '',
	$rabbitmq_addr			= '127.0.0.1',
	$rabbitmq_user			= 'rabbitmq_user',
	$rabbitmq_passwd		= 'rabbitmq_passwd',
	$dough_loglevel			= 'info',
# dough setting
# deduct setting
	$cachetime				= '5',
# filter:auth setting
	$auth_host				= '0.0.0.0',
	$admin_token,
# region.py.example.erb setting
	$default_region			= 'http://127.0.0.1:35357/v2.0/',
	$region_name			= "RegionOne",
	$region_endpoint		= "http://127.0.0.1:35357/v2.0/"
){
  include 'concat::setup'

  package { 'deduct':
	ensure => present
  }

  package { 'dough-common':
	ensure	=> present,
  }
 
  file { '/etc/dough':
    ensure  => directory,
    owner   => 'dough',
    group   => 'dough',
    mode    => 0755,
    require => Package['dough-common'],
  }
  concat { '/etc/dough/dough.conf':
    owner   => 'dough',
    group   => 'dough',
    mode    => '0600',
    require => Package['dough-common'],
  }
	
#Config set 
	dough::config {'DEFAULT':
		config => {
		    listen					=> $listen,	
			host					=> $host,
			sql_connection			=> $sql_connection,
			nova_sql_connection		=> $sql_connection,
			memcache				=> $memcache,
			keystone_username		=> $keystone_username,
			keystone_password		=> $keystone_password,
			keystone_tenant_name	=> $keystone_tenant_name,
			keystone_auth_url		=> $keystone_auth_url,
			purchases_buffer		=> $purchases_buffer,
			migrate_url				=> $migrate_url,
			migrate_databases		=> $migrate_databases,
			rabbitmq_addr			=> $rabbitmq_addr,
			rabbitmq_user			=> $rabbitmq_user,
			rabbitmq_passwd			=> $rabbitmq_passwd,
			loglevel				=> $dough_loglevel,
			nova_db_username        => $nova_db_username,
			nova_db_passwd          => $nova_db_passwd,
			nova_db_host            => $nova_db_host,
			nova_db_name            => $nova_db_name,
			},
			order	=> '01',
	}	
	dough::config {'dough':
			order	=> '02',
	}
	dough::config {'deduct':
		config => {
			cachetime	=> $cachetime,
			},
			order	=> '03',
	}		
	dough::config {'auth':
		config => {
			auth_host		=> $auth_host,
			admin_token		=> $admin_token,
			},
			order	=> '04',
	}

	file {'/usr/lib/python2.7/dist-packages/dough/region.py':
		ensure  => 'present',
		content => template("dough/region.py.example.erb"),
		require => Package['dough-common'],
		}
 }
