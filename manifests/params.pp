class mac_admin::params{
    if ($::operatingsystem=='Darwin') and ($::macosx_productversion_major >= '10.7'){
        $repourl = 'http://munki'
        $clientidentifier = $::sp_serial_number
        $suppressautoinstall = false
        $install_apple_updates = false
        $suppress_stop = false
        $bootstrap = false
        $packageurl = ''
        $catalogurl = ''
        $manifesturl = ''
        $namerurl = 'http://macnamer'
        $crypturl = 'http://crypt'
        $default_group = 'everyone'
        $hook_priority = '0'
    }else{
        fail('unsupported operating system')
    }
}