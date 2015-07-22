Puppet::Type.type(:mac_hide_user).provide(:osx) do
  desc "Hides the user from the login window specified in the namevar"
  confine :operatingsystem => :darwin
  confine :macosx_productversion_major => ["10.10", "10.11"]

  defaultfor :operatingsystem => :darwin

  commands :dscl => '/usr/bin/dscl'

  def get_dscl_user
    begin
      output = dscl(['.', 'read', '/Users/#{namevar}', 'IsHidden'])
    rescue Puppet::ExecutionFailure => e
      Puppet.debug("#get_dscl_user had an error -> #{e.inspect}")
      return nil
    end
    if output =~ /No such key: IsHidden/
        return nil
    elsif outpt =~ /dsAttrTypeNative:IsHidden: 1/
        return nil
    else
        output
    end
  end

  def exists?
    get_dscl_user != nil
  end

  def create
    dscl(['.', 'read', '/Users' + :namevar, 'IsHidden', '1'])
  end

  def destroy
    dscl(['.', 'read', '/Users' + :namevar, 'IsHidden', '0'])
  end
end
