# == Class: mac_admin::authorization::date_time
#
# Allows the specified group to modify the Date & Time system preference
# === Parameters
# [*group*]
#   The group to which System Preferences should be opened up to. Defaults to everyone
#
# [*ensure*]
#   Whether this should be applied or not. Defaults to "present". Set to "absent" to remove.
#
# === Examples
#
#  class { 'mac_admin::authorization::date_time':
#    group  => "everyone",
#  }

#

class mac_admin::authorization::date_time(
    $group = $mac_admin::params::default_group,
    ) inherits mac_admin::params {

	include mac_admin::authorization::setup
	
    macauthorization { 'system.preferences.datetime':
      ensure     => 'present',
      allow_root => 'true',
      auth_class => 'user',
      auth_type  => 'right',
      comment    => 'Changed by Puppet',
      group      => $group,
      shared     => 'true',
    }
}