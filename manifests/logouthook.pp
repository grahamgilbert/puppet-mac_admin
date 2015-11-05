# == Class: mac_admin::logouthook
#
# Configures logouthooks
#
# === Parameters
#
# [*priority*]
#   The priority of the script. 0 is run first, then in ascending order. Defaults to 0
#
# [*script*]
#   The actual script to run
#
# === Example
#
#  mac_admin::logouthook { 'my_logout_hook':
#    priority => '10',
#    script => 'puppet:///modules/mymodule/myscript.sh,
#  }
#

define mac_admin::logouthook(
    $script,
    $priority = $mac_admin::params::hook_priority,
    ) {
    include mac_admin::params
    if ! defined(File"${::puppet_vardir}/mac_admin"]) {
        file { "${::puppet_vardir}/mac_admin":
            ensure => directory,
        }
    }

    if ! defined(File"${::puppet_vardir}/mac_admin/hooks"]) {
        file { "${::puppet_vardir}/mac_admin/hooks":
            ensure => directory,
        }
    }

    if ! defined(File"${::puppet_vardir}/mac_admin/hooks/logout"]) {
        file { "${::puppet_vardir}/mac_admin/hooks/logout":
            ensure => directory,
        }
    }

    if ! defined(File["${::puppet_vardir}/mac_admin/hooks/logout_hook"]) {
        file {"${::puppet_vardir}/mac_admin/hooks/logout_hook":
            source  => 'puppet:///modules/mac_admin/hooks/logout_hook',
            owner   => 0,
            group   => 0,
            mode    => '0755',
        }
    }

    file {"${::puppet_vardir}/mac_admin/hooks/logout/${priority}-${title}":
        source => $script,
        owner  => 0,
        group  => 0,
        mode   => '0755',
    }

    if ! defined(Mac_admin::Osx_defaults['mac_admin-logouthook']){
         mac_admin::osx_defaults { 'mac_admin-logouthook':
            ensure => present,
            domain => '/var/root/Library/Preferences/com.apple.loginwindow',
            key    => 'LogoutHook',
            value  => '/var/lib/puppet/mac_admin/hooks/logout_hook'
        }
    }
}
