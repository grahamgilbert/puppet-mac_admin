# == Class: mac_admin::sus
#
# Installs a configuration profile with SUS settings
#
# === Parameters
#
# [*107_sus_url*]
#   The URL that Macs running Mac OS X 10.7 should look at
#
# [*108_sus_url*]
#   The URL that Macs running Mac OS X 10.8 should look at
#
# [*sus_url*]
#   A unified sus url. If an OS specific URL is passed, that will be used instead
#
# === Examples
#
#  class { 'mac_admin::sus':
#    sus_url_107 => 'http://sus.example.com/content/catalogs/others/index-lion-snowleopard-leopard.merged-1.sucatalog',
#    sus_url_108 => 'http://sus.example.com/content/catalogs/others/index-mountainlion-lion-snowleopard-leopard.merged-1.sucatalog',
#  }
#

class mac_admin::sus(
    $sus_url_107 = undef,
    $sus_url_108 = undef,
    $sus_url_109 = undef,
    $sus_url_1010 = undef,
    $sus_url_1011 = undef,
    ) inherits mac_admin::params {
    ## Set the url for each OS
    case $::macosx_productversion_major {
        default:{
            fail('Unsupported version of OS X.')
        }
        10.7:{
            if $sus_url_107 != false {
                $sus_url = $sus_url_107
            }
        }
        10.8:{
            if $sus_url_108 != false{
                $sus_url = $sus_url_108
            }
        }
        10.9:{
            if $sus_url_109!=false{
                $sus_url = $sus_url_109
            }
        }

        10.10:{
            if $sus_url_1010!=false{
                $sus_url = $sus_url_1010
            }

        10.11:{
            if $sus_url_1011!=false{
                $sus_url = $sus_url_1011
            }
        }
    }

    if ! defined(File['/var/lib/puppet/mac_admin']) {
        file { '/var/lib/puppet/mac_admin':
            ensure => directory,
        }
    }

    # If the sus_url has been set, create and install the profile
    if $sus_url != false {
        file {'/var/lib/puppet/mac_admin/com.grahamgilbert.susprefs.mobileconfig':
            content => template('mac_admin/com.grahamgilbert.susprefs.erb'),
            owner   => 0,
            group   => 0,
            mode    => '0755',
        }

        ##Install the profile
        mac_profiles_handler::manage { 'com.grahamgilbert.susprefs':
            ensure      => present,
            file_source => '/var/lib/puppet/mac_admin/com.grahamgilbert.susprefs.mobileconfig',
            require     => File['/var/lib/puppet/mac_admin/com.grahamgilbert.susprefs.mobileconfig']
        }
    }
}
