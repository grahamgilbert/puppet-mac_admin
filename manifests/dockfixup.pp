# == Class: mac_admin::dockfixup
#
# Removes the file that adds the extra junk like Notes to a new 10.8 docl
#
# === Example
#
#  class { 'mac_admin::dockfixup': }
#

class mac_admin::dockfixup (
) inherits mac_admin::params {
    file { '/Library/Preferences/com.apple.dockfixup.plist':
        ensure  => 'absent',
    }
}