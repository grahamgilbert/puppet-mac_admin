class mac_admin::munki::conditions{

    if ! defined(File['/usr/local']) {
        file { '/usr/local':
            ensure => directory,
        }
    }

    if ! defined(File['/usr/local/munki']) {
        file { '/usr/local/munki':
            ensure => directory,
        }
    }


    if ! defined(File['/usr/local/munki/conditions']) {
        file { '/usr/local/munki/conditions':
            ensure => directory,
        }
    }

  file {'/usr/local/munki/conditions/external_ip.py':
    ensure => present,
    source => 'puppet:///modules/mac_admin/munki_conditions/external_ip.py',
    mode   => '0755',
    owner  => 0,
    group  => 0,
  }

}
