Puppet::Type.type(:mac_sus_schedule).provide(:osx) do
  desc "Enables and disables automatic software update checks"
  confine :operatingsystem => :darwin
  
  defaultfor :operatingsystem => :darwin
  
  commands :softwareupdate => '/usr/sbin/softwareupdate'
  
  def get_sus_schedule
    begin
      output = softwareupdate('--schedule')
    rescue Puppet::ExecutionFailure => e
      Puppet.debug("#get_sus_schedule had an error -> #{e.inspect}")
      return nil
    end
    return nil if output =~ /Automatic check is off/
    output
  end
  
  def exists?
    get_sus_schedule != nil
  end
  
  def create
    softwareupdate(['--schedule','on'])
  end
  
  def destroy
    softwareupdate(['--schedule','off'])
  end
end