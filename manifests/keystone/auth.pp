#
# Sets up dough users, service and endpoint
#
# == Parameters:
#
#  $auth_name :: identifier used for all keystone objects related to dough.
#    Optional. Defaults to dough.
#  $password :: password for dough user. Optional. Defaults to dough_password.
#  $service_type :: type of service to create. Optional. Defaults to image.
#  $public_address :: Public address for endpoint. Optional. Defaults to 127.0.0.1.
#  $admin_address :: Admin address for endpoint. Optional. Defaults to 127.0.0.1.
#  $inernal_address :: Internal address for endpoint. Optional. Defaults to 127.0.0.1.
#  $port :: Port for endpoint. Needs to match dough api service port. Optional.
#    Defaults to 9292.
#  $region :: Region where endpoint is set.
#
class dough::keystone::auth(
  $auth_name          = 'dough',
  $tenant			  = 'services',
  $password           = 'dough',
  $configure_endpoint = true,
  $service_type       = 'dough',
  $public_address     = '127.0.0.1',
  $admin_address      = '127.0.0.1',
  $internal_address   = '127.0.0.1',
  $port               = '5556',
  $region             = 'RegionOne'
) {

  Keystone_user["$auth_name"] ~> Keystone_user_role["${auth_name}@${tenant}"] ~> Service <| name == 'dough-server' |>
  Keystone_user["$auth_name"] ~> Keystone_user_role["${auth_name}@${tenant}"] ~> Service <| name == 'dough-api' |>

  keystone_user { $auth_name:
    ensure   => present,
    password => $password,
	tenant   => 'services',
  }
  keystone_user_role { "${auth_name}@${tenant}":
    ensure  => present,
    roles   => 'admin',
  }
  keystone_service { $auth_name:
    ensure      => present,
    type        => $service_type,
    description => "Openstack Dough Service",
  }
  if $configure_endpoint {
    keystone_endpoint { "${region}/$auth_name":
      ensure       => present,
      region       => $region,
      public_url   => "http://${public_address}:${port}/v1.0",
      admin_url    => "http://${admin_address}:${port}/v1.0",
      internal_url => "http://${internal_address}:${port}/v1.0",
    }
  }
}
