# == Class: mac_admin::authorization::setup
#
# Opens up system preferences, we need this before anything else can happen.
# === Parameters
# [*group*]
#   The group to which System Preferences should be opened up to. Defaults to everyone
#
# [*ensure*]
#   Whether this should be applied or not. Defaults to "present". Set to "absent" to remove.
#
# === Examples
#
#  class { 'mac_admin::authorization::setup':
#    group  => "everyone",
#    ensure => "present",
#  }
#

class mac_admin::authorization::setup(
    $group = $mac_admin::params::default_group,
    $ensure = $mac_admin::params::authorization_ensure,
    ) inherits mac_admin::params {

    macauthorization { 'system.preferences':
      ensure    => $ensure,
      comment   => "Changed by Puppet",
      group     => $group,
      auth_type => 'right',
    }
}