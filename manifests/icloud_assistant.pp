# == Class: mac_admin::icloud_assistant
#
# Installs a configuration profile that skips the iCloud Setup Assistant on first login on Macs running 10.8
#
# === Example
#
#  class { 'mac_admin::lowing_window_hostname': }
#

class mac_admin::icloud_assistant(
) inherits mac_admin::params {
    ##Install the profile
    mac_profiles_handler::manage { 'com.grahamgilbert.icloud_assistant':
        ensure      => present,
        file_source => 'puppet:///modules/mac_admin/icloud_assistant/com.grahamgilbert.icloud_assistant.mobileconfig',
    }
}