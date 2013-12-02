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
    $priority = $mac_admin::params::hook_priority,
    $script,
    ) {
    include mac_admin::params
    include macdefaults
    if ! defined(File['/var/lib/puppet/mac_admin']) {
      file { '/var/lib/puppet/mac_admin':
        ensure => directory,
      }
    }
    
    if ! defined(File['/var/lib/puppet/mac_admin/hooks']) {
      file { '/var/lib/puppet/mac_admin/hooks':
        ensure => directory,
      }
    }
    
    if ! defined(File['/var/lib/puppet/mac_admin/hooks/logout']) {
      file { '/var/lib/puppet/mac_admin/hooks/logout':
        ensure => directory,
      }
    }

    if ! defined(File['/var/lib/puppet/mac_admin/hooks/logout_hook']) {
        file {'/var/lib/puppet/mac_admin/hooks/logout_hook':
            source  => 'puppet:///modules/mac_admin/hooks/logout_hook',
            owner   => 0,
            group   => 0,
            mode    => '0755',
        }
    }
    
    file {"/var/lib/puppet/mac_admin/hooks/logout/${priority}-${title}":
        source => $script,
        owner  => 0,
        group  => 0,
        mode   => '0755',
    }
    
	if ! defined(Mac-defaults['mac_admin-logouthook']){
        mac-defaults { "mac_admin-logouthook":
    		domain => '/var/root/Library/Preferences/com.apple.loginwindow',
    		key => 'LogoutHook',
    		value => '/var/lib/puppet/mac_admin/hooks/logout_hook',
    		type => 'string',
    	} 
    }

    
}