#!/usr/bin/python
import urllib2
import sys
import os
import time
import plistlib
from Foundation import CFPreferencesCopyAppValue

def get_wan():
  ext_ip = None
  try:
    ext_ip = urllib2.urlopen('http://icanhazip.com/').read().strip()
  except:
    pass
  return ext_ip

def write_conditional():
  # Read the location of the ManagedInstallDir from ManagedInstall.plist
  BUNDLE_ID = 'ManagedInstalls'
  pref_name = 'ManagedInstallDir'
  managedinstalldir = CFPreferencesCopyAppValue(pref_name, BUNDLE_ID)
  # Make sure we're outputting our information to "ConditionalItems.plist"
  conditionalitemspath = os.path.join(managedinstalldir, 'ConditionalItems.plist')
  if os.path.exists(conditionalitemspath):
    # "ConditionalItems.plist" exists, so read it FIRST
    data_dict = plistlib.readPlist(conditionalitemspath)
  else:
    # "ConditionalItems.plist" does not exist,
    # create an empty dict
    data_dict = {}
  external_ip = get_wan()
  # Write out data to "ConditionalItems.plist"
  data_dict['external_ip'] = external_ip
  plistlib.writePlist(data_dict, conditionalitemspath)

def main():
  write_conditional()

if __name__ == '__main__':
  main()
