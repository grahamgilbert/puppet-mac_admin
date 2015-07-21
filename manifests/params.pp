# just some defaults
class mac_admin::params{
    if ($::operatingsystem=='Darwin') {
        $repourl = 'http://munki'
        $clientidentifier = ''
        $suppressautoinstall = false
        $install_apple_updates = false
        $suppress_stop = false
        $bootstrap = false
        $packageurl = ''
        $catalogurl = ''
        $manifesturl = ''
        $namerurl = 'http://macnamer'
        $crypturl = 'http://crypt'
        $hook_priority = '0'
    }else{
        fail('unsupported operating system')
    }
}
