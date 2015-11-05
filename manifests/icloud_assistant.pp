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
    if ! defined(File["${::puppet_vardir}/mac_admin"]) {
        file { "${::puppet_vardir}/mac_admin":
            ensure => directory,
        }
    }

    ##Write out the contents of the template to a mobileconfig file (this needs to be cleaned up)
    file {'/var/lib/puppet/mac_admin/com.grahamgilbert.icloud_assistant.mobileconfig':
        content => template('mac_admin/com.grahamgilbert.icloud_assistant.erb'),
        owner   => 0,
        group   => 0,
        mode    => '0755',
    }

    ##Install the profile
    mac_profiles_handler::manage { 'com.grahamgilbert.icloud_assistant':
        ensure      => present,
        file_source => '/var/lib/puppet/mac_admin/com.grahamgilbert.icloud_assistant.mobileconfig',
        require     => File['/var/lib/puppet/mac_admin/com.grahamgilbert.icloud_assistant.mobileconfig']
    }

    # Defaults as the profile isn't working

    mac_admin::osx_defaults { 'DidSeeCloudSetup':
        ensure => present,
        domain => '/System/Library/User\ Template/Non_localized/Library/Preferences/com.apple.SetupAssistant',
        key    => 'DidSeeCloudSetup',
        value  => true,
        type   => 'bool',
    }

    mac_admin::osx_defaults { 'LastSeenCloudProductVersion':
        ensure => present,
        domain => '/System/Library/User\ Template/Non_localized/Library/Preferences/com.apple.SetupAssistant',
        key    => 'LastSeenCloudProductVersion',
        value  => $::macosx_productversion,
    }
}
