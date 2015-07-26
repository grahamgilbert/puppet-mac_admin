# == Class: mac_admin::disable_airdrop
#
# Installs a configuration profile to disable AirDrop
#
# === Example
#
#  class { 'mac_admin::disable_airdrop': }
#

class mac_admin::disable_airdrop(
) inherits mac_admin::params {
    ##Install the profile
    mac_profiles_handler::manage { 'com.grahamgilbert.disableairdrop':
        ensure      => present,
        file_source => 'puppet:///modules/mac_admin/disable_airdrop/com.grahamgilbert.disableairdrop.mobileconfig',
    }
}