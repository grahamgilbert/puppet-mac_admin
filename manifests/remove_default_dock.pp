# == Class: mac_admin::remove_default_dock
#
# No matter how hard you try, Apple insists that you need Notes, Reminders and the App Store in a 10.8 default dock. This class installs a LaunchAgent to remove them.
#

class mac_admin::remove_default_dock(
    ) inherits mac_admin::params {
    
    if !defined(File['/System/Library/User Template/Non_localized/Library']){
            file { '/System/Library/User Template/Non_localized/Library/':
                ensure => directory,
                owner  => root,
                group  => wheel,
                mode   => '0600',
            }
        }
	
	if !defined(File['/System/Library/User Template/Non_localized/Library/LaunchAgents']){
            file { '/System/Library/User Template/Non_localized/Library/LaunchAgents/':
                ensure => directory,
                owner  => root,
                group  => wheel,
                mode   => '0600',
            }
        }
        
    if ! defined(File['/var/lib/puppet/mac_admin']) {
      file { '/var/lib/puppet/mac_admin':
        ensure => directory,
      }
    }
    
    file { '/var/lib/puppet/mac_admin/remove_default_dock':
        ensure => present,
        source => 'puppet:///modules/mac_admin/remove_default_dock/remove_default_dock',
        owner => root,
        group => wheel,
        mode => 755,
    }
    
    file { '/var/lib/puppet/mac_admin/dockutil':
        ensure => present,
        source => 'puppet:///modules/mac_admin/remove_default_dock/dockutil',
        owner => root,
        group => wheel,
        mode => 755,
    }
        
	file { '/System/Library/User Template/Non_localized/Library/LaunchAgents/com.grahamgilbert.remove_default_dock.plist':
        ensure => present,
        source => 'puppet:///modules/mac_admin/remove_default_dock/com.grahamgilbert.remove_default_dock.plist',
        owner => root,
        group => wheel,
        mode => 644,
    }    
}