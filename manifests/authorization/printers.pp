# == Class: mac_admin::authorization::printers
#
# Allows the specified group to modify the Print and Scan system preference
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

class mac_admin::authorization::printers(
    $group = $mac_admin::params::default_group,
    ) inherits mac_admin::params {

    include mac_admin::authorization::setup
    if $::macosx_productversion_major != '10.9'{
        macauthorization { 'system.preferences.printing':
          ensure     => 'present',
          allow_root => 'true',
          auth_class => 'user',
          auth_type  => 'right',
          comment    => 'Changed by Puppet',
          group      => $group,
          shared     => 'true',
          notify     => Exec['Add the $group to the _lpadmin group'],
        }
    
        exec { 'Add the $group to the _lpadmin group':
            command     => "/usr/sbin/dseditgroup -o edit -a ${group} -t group lpadmin",
            refreshonly => true,
        }
    }
}