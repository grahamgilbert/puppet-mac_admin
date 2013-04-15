# == Class: mac_admin
#
# A collection of classes for managing OS X machines
#

class mac_admin(
    $repourl = $munki_setup::params::repourl,
    $clientidentifier = $munki_setup::params::clientidentifier,
    $suppressautoinstall = $munki_setup::params::suppressautoinstall,
    $suppress_stop = $munki_setup::params::suppress_stop,
    $bootstrap = $munki_setup::params::bootstrap,
    ) inherits mac_admin::params {
}