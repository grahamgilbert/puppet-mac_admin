# == Class: mac_admin::loginhook
#
# Configures loginhooks
#
# === Parameters
#
# [*priority*]
#   The priority of the script. 0 is run first, then in ascending order. Defaults to 0
#
# [*script*]
#   The actual script to run
#
# [*ensure*]
#   Whether the script is present or absent. Defaults to present
#
# === Example
#
#  mac_admin::loginhook { 'my_login_hook':
#    priority => '10',
#    script => 'puppet:///modules/mymodule/myscript.sh,
#  }
#

define mac_admin::loginhook(
    $script,
    $priority = $mac_admin::params::hook_priority,
    $ensure   = 'present'
    ) {
    include mac_admin::params
    if ! defined(File"${::puppet_vardir}/mac_admin/hooks"]) {
        file { "${::puppet_vardir}/mac_admin/hooks":
            ensure => directory,
        }
    }

    if ! defined(File"${::puppet_vardir}/mac_admin/hooks/login"]) {
        file { "${::puppet_vardir}/mac_admin/hooks/login":
            ensure => directory,
        }
    }

    if ! defined(File["${::puppet_vardir}/mac_admin/hooks/login_hook"]) {
        file {"${::puppet_vardir}/mac_admin/hooks/login_hook":
            source  => 'puppet:///modules/mac_admin/hooks/login_hook',
            owner   => 0,
            group   => 0,
            mode    => '0755',
        }
    }

    file {"${::puppet_vardir}/mac_admin/hooks/login/${priority}-${title}":
        source => $script,
        owner  => 0,
        group  => 0,
        mode   => '0755',
    }

    if ! defined(Mac_admin::Osx_defaults['mac_admin-loginhook']){
         mac_admin::osx_defaults { 'mac_admin-loginhook':
            ensure => present,
            domain => '/var/root/Library/Preferences/com.apple.loginwindow',
            key    => 'LoginHook',
            value  => '/var/lib/puppet/mac_admin/hooks/login_hook'
        }
    }
}
