# Public: Add a recovery message to the OS X Lock Screen
# This was taken almost vertabim from Github's Boxen
#
# Examples
#
#   mac_admin::recovery_message { 'If this Mac is found, please call 123-123-1234': }
define mac_admin::recovery_message(
  $ensure = 'present',
  $value  = $name,
) {
  $kextdir     = '/System/Library/Extensions'
  $eficachedir = '/System/Library/Caches/com.apple.corestorage/EFILoginLocalizations'

  # The CoreStorage kext cache needs to be updated so the recovery message
  # is displayed on the FDE pre-boot screen.
  #
  # The CS cache can be updated directly by touching $eficachedir, if it exists.
  # Otherwise you will need to touch $kextdir to generate it.
  exec { 'Refresh system kext cache':
      command     => "/usr/bin/touch ${kextdir}",
      creates     => $eficachedir,
      refreshonly => true,
      user        => root
  }

  exec { 'Refresh CoreStorage EFI Cache':
      command     => "/usr/bin/touch ${eficachedir}",
      onlyif      => "/bin/test -d ${eficachedir}",
      refreshonly => true,
      user        => root
  }

  if $ensure == 'present' {
    if $value != undef {

        mac_admin::osx_defaults { 'Set OS X Recovery Message':
            ensure => present,
            domain => '/Library/Preferences/com.apple.loginwindow',
            key    => 'LoginwindowText',
            value  => $value,
            #user   => root
        }

      exec { 'Set OS X Recovery Message NVRAM Variable':
        command => "/usr/sbin/nvram good-samaritan-message='${value}'",
        unless  => "/usr/sbin/nvram good-samaritan-message | awk -F'\t' '{ print \$2 }' | grep '^${value}$'",
        user    => root
      }
    } else {
      fail('Cannot set an OS X recovery message without a value')
    }
  } else {
      mac-defaults { "Remove OS X Recovery Message":
  		domain => '/Library/Preferences/com.apple.loginwindow',
  		key => 'LoginwindowText',
  		value => "${value}",
  		#type => 'string',
        action => 'delete',
        notify => [
              Exec['Refresh system kext cache'],
              Exec['Refresh CoreStorage EFI Cache']
            ]
  	    }

    exec { 'Remove OS X Recovery Message NVRAM Variable':
      command => '/usr/sbin/nvram -d good-samaritan-message',
      onlyif  => '/usr/sbin/nvram -p | grep good-samaritan-message',
      user    => root
    }
  }
}
