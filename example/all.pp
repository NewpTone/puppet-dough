$nova_db_username       = 'nova'
$nova_db_passwd         = 'nova'
$nova_db_host           = '127.0.0.1'
$nova_db_name           = 'nova'
$dough_db_username      = 'dough'
$dough_db_passwd        = 'dough'
$dough_db_host          = '127.0.0.1'
$dough_db_name          = 'dough'
$sql_connection         = '' 
#$nova_sql_connection    = '' 
# Default setting
$listen                 = '0.0.0.0'
$host                   = '127.0.0.1'
$region                 = 'regionone'
$dough_token            = 'admin'
$memcache               = '127.0.0.1:11211'
$keystone_username      = 'keystone'
$keystone_password      = 'keystone'
$keystone_tenant_name   = 'keystone_teanant'
$keystone_auth_url      = 'keystone_auth_url'
$purchases_buffer       = 'purchases_buffer'
$migrate_url            = 'mysql://root:nova@localhost/'
$migrate_databases      = '' 
$rabbitmq_addr          = '127.0.0.1'
$rabbitmq_user          = 'rabbitmq_user'
$rabbitmq_passwd        = 'rabbitmq_passwd'
$loglevel               = 'info'
# dough setting
# deduct setting
$cachetime              = '5'
# filter:auth setting
$auth_host              = '0.0.0.0'
$admin_token			= 'dough_token'

node /dough_all/  {
class {'dough':
	nova_db_username		=> $nova_db_username,
	nova_db_passwd			=> $nova_db_passwd,
	nova_db_host			=> $nova_db_host,
	nova_db_name			=> $nova_db_name,
	dough_db_username		=> $dough_db_username,
	dough_db_passwd			=> $dough_db_passwd,
	dough_db_host			=> $dough_db_host,
	dough_db_name			=> $dough_db_name,
	sql_connection			=> $sql_connection,
	listen					=> $listen,
	host					=> $host,
	region					=> $region,
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
	loglevel				=> $loglevel,
	cachetime				=> $cachetime,
	auth_host				=> $auth_host,
	admin_token				=> $admin_token,
	sql_connection			=> "mysql://${dough_db_username}:${dough_db_passwd}@${dough_db_host}/${dough_db_name}",
}

class {'dough::api':}

class {'dough::farmer':}

}

