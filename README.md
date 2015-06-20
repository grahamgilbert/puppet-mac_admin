puppet-mac_admin
================

A Puppet module to administer Mac OS X Machines

## Changes in 0.2.0

* All of the Authorization classes were removed, since they've been completely broken since 10.9, and there are now other ways to manage this (with using [Munki](http://grahamgilbert.com/blog/2013/12/22/managing-the-authorization-database-with-munki/)) or another Puppet Module.
* Removed the dockfixup class - once again, there are other, better methods of managing the Dock.

## Requirements

* [rcoleman/mac_profiles_handler](http://forge.puppetlabs.com/rcoleman/mac_profiles_handler)
* [grahamgilbert/macdefaults](http://forge.puppetlabs.com/grahamgilbert/macdefaults)
