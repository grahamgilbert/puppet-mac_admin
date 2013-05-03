# == Class: mac_admin::crypt
#
# Installs a configuration profile with Crypt settings
#
# === Parameters
#
# [*crypturl*]
#   The URL of your MacNamer server. Defaults to http:crypt
#
# === Example
#
#  class { 'mac_admin::macnamer':
#    namerurl => "http://macnamer.example.com",
#  }
#

class mac_admin::crypt(
    $crypturl = $mac_admin::params::crypturl,
    ) inherits mac_admin::params {

    if ! defined(File['/var/lib/puppet/mac_admin']) {
      file { '/var/lib/puppet/mac_admin':
        ensure => directory,
      }
    }

    ##Write out the contents of the template to a mobileconfig file (this needs to be cleaned up)
    file {'/var/lib/puppet/mac_admin/com.grahamgilbert.crypt.mobileconfig':
        content => template('mac_admin/com.grahamgilbert.crypt.erb'),
        owner   => 0,
        group   => 0,
        mode    => '0755',
    }

    ##Install the profile
    mac_profiles_handler::manage { 'com.grahamgilbert.crypt':
        ensure      => present,
        file_source => '/var/lib/puppet/mac_admin/com.grahamgilbert.crypt.mobileconfig',
        require     => File['/var/lib/puppet/mac_admin/com.grahamgilbert.crypt.mobileconfig']
    }
}