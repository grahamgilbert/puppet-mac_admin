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
#  }
#

class mac_admin::authorization::setup(
    $group = $mac_admin::params::default_group,
    ) inherits mac_admin::params {

    if $::macosx_productversion_major != '10.9'{    
        macauthorization { 'system.preferences':
          ensure    => 'present',
          comment   => 'Changed by Puppet',
          group     => $group,
          auth_type => 'right',
        }
    }
}