# == Class: mac_admin::macnamer
#
# Installs Munki and installs a configuration profile with Munki settings
#
# === Parameters
#
# [*namerurl*]
#   The URL of your MacNamer server. Defaults to http://macnamer
#
# === Example
#
#  class { 'mac_admin::macnamer':
#    namerurl => "http://macnamer.example.com",
#  }
#

class mac_admin::macnamer(
    $namerurl = $mac_admin::params::namerurl,
    $key
    ) inherits mac_admin::params {

    if ! defined(File['/var/lib/puppet/mac_admin']) {
      file { '/var/lib/puppet/mac_admin':
        ensure => directory,
      }
    }

    ##Write out the contents of the template to a mobileconfig file (this needs to be cleaned up)

    file {'/var/lib/puppet/mac_admin/com.grahamgilbert.macnamer.mobileconfig':
        content => template('mac_admin/com.grahamgilbert.macnamer.erb'),
        owner   => 0,
        group   => 0,
        mode    => '0755',
    }

    ##Install the profile
    mac_profiles_handler::manage { 'com.grahamgilbert.macnamer':
        ensure      => present,
        file_source => '/var/lib/puppet/mac_admin/com.grahamgilbert.macnamer.mobileconfig',
        require     => File['/var/lib/puppet/mac_admin/com.grahamgilbert.macnamer.mobileconfig']
    }
}
