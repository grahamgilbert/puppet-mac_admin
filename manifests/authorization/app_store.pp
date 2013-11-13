# == Class: mac_admin::authorization::app_store
#
# Allows the specified group to install and update apps from the App Store
# === Parameters
# [*group*]
#   The group to which System Preferences should be opened up to. Defaults to everyone
#
# [*ensure*]
#   Whether this should be applied or not. Defaults to "present". Set to "absent" to remove.
#
# === Examples
#
#  class { 'mac_admin::authorization::app_store':
#    group  => "everyone",
#  }
#

class mac_admin::authorization::app_store(
    $group = $mac_admin::params::default_group,
    ) inherits mac_admin::params {

    include mac_admin::authorization::setup

    if $::macosx_productversion_major != '10.9'{
        macauthorization { 'system.install.app-store-software':
            ensure     => 'present',
            auth_class => 'rule',
            auth_type  => 'right',
            comment    => 'Changed by Puppet',
            rule       => 'allow',
        }
    }
}