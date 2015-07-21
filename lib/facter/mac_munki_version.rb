#mac_munki_version.rb
Facter.add(:mac_munki_version) do
  confine :kernel => "Darwin"
  setcode do
    Facter::Util::Resolution.exec("/usr/local/munki/managedsoftwareupdate --version")
  end
end
