# == Class: mac_admin::remove_default_dock
#
# No matter how hard you try, Apple insists that you need Notes, Reminders and the App Store in a 10.8 default dock.
# This class removes the plist that creates them.
#

class mac_admin::remove_default_dock(
    ) inherits mac_admin::params {

    file {'/Library/Preferences/com.apple.dockfixup.plist':
        ensure => absent,
    }
    
    # Clear up the old plist if someone is upgrading
    file { '/System/Library/User Template/Non_localized/Library/LaunchAgents/com.grahamgilbert.remove_default_dock.plist':
        ensure => absent,
    }
}