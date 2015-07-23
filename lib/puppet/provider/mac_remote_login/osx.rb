Puppet::Type.type(:mac_remote_login).provide(:osx) do
  desc "Enables and disables remote login (SSH)"
  confine :operatingsystem => :darwin

  defaultfor :operatingsystem => :darwin

  commands :systemsetup => '/usr/sbin/systemsetup'

  def get_remote_login
    begin
      output = systemsetup('-getremotelogin')
    rescue Puppet::ExecutionFailure => e
      Puppet.debug("#mac_remote_login had an error -> #{e.inspect}")
      return nil
    end
    return nil if output =~ /Remote Login: Off/
    output
  end

  def exists?
    get_remote_login != nil
  end

  def create
    systemsetup(['-setremotelogin','on'])
  end

  def destroy
    systemsetup(['-setremotelogin','off'])
  end
end
