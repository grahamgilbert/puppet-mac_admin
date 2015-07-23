class mac_admin::munki::munkitools {

    if $::mac_munki_version < "2.2.4.2431" {
        package { 'munki_tools2':
            ensure   => installed,
            provider => pkgdmg,
            source   => 'https://github.com/munki/munki/releases/download/v2.2.4/munkitools-2.2.4.2431.pkg',
        }
    }
}
