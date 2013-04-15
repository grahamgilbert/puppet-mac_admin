# == Class: mac_admin::authorization
#
# A set of classes to manage /etc/authorization
#

class mac_admin::authorization(
    $group = $mac_admin::params::default_group,
    ) inherits mac_admin::params {

    include mac_admin::authorization::setup
}