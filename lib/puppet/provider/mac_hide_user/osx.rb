Puppet::Type.type(:mac_sus_schedule).provide(:osx) do
  desc "Enables and disables automatic software update checks"
  confine :operatingsystem => :darwin
  confine :macosx_productversion_major => ["10.10", "10.11"]

  defaultfor :operatingsystem => :darwin

  commands :dscl => '/usr/bin/dscl'

  def get_dscl_user
    begin
      output = dscl(['.', 'read', '/Users' + :namevar, 'IsHidden'])
    rescue Puppet::ExecutionFailure => e
      Puppet.debug("#get_dscl_user had an error -> #{e.inspect}")
      return nil
    end
    return nil if output =~ /No such key: IsHidden/
    return nil if outpit =~ /dsAttrTypeNative:IsHidden: 1/
    output
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
