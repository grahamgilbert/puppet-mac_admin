Puppet::Type.type(:mac_hide_user).provide(:osx) do
  desc "Hides the user from the login window specified in the namevar"
  confine :operatingsystem => :darwin
  confine :macosx_productversion_major => ["10.10", "10.11", "10.12", "10.13"]

  defaultfor :operatingsystem => :darwin

  commands :dscl => '/usr/bin/dscl'

  def get_dscl_user(name)
    begin
      output = dscl(['.', 'read', '/Users/'+ name.to_s, 'IsHidden'])
    rescue Puppet::ExecutionFailure => e
      Puppet.debug("#get_dscl_user had an error -> #{e.inspect}")
      return nil
    end
    return nil if output =~ /No such key: IsHidden/
    return nil if output =~ /dsAttrTypeNative:IsHidden: 0/
    output
  end

  def exists?
    get_dscl_user(resource[:name]) != nil
  end

  def create
    dscl(['.', 'create', '/Users/' + resource[:name.to_s], 'IsHidden', '1'])
  end

  def destroy
    dscl(['.', 'create', '/Users/' + resource[:name.to_s], 'IsHidden', '0'])
  end
end
