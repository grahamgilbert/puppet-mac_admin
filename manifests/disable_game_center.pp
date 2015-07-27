# == Class: mac_admin::disable_game_center
#
# Installs a configuration profile to disable Game Center
#
# === Example
#
#  class { 'mac_admin::disable_game_center': }
#

class mac_admin::disable_game_center(
) inherits mac_admin::params {
    ##Install the profile
    mac_profiles_handler::manage { 'com.grahamgilbert.diablegamecenter':
        ensure      => present,
        file_source => 'puppet:///modules/mac_admin/disable_game_center/com.grahamgilbert.diablegamecenter.mobileconfig',
    }
}