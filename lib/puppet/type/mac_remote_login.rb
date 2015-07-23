Puppet::Type.newtype(:mac_remote_login) do
  @doc = "Enables and disables remote login (SSH)"

  newparam(:name, :namevar => true)

  ensurable do
          desc "Possible values are *present*, *absent*, *on*, and *off*."

          newvalue(:absent) do
              if @resource.provider.exists?
                  @resource.provider.destroy
              end
          end
          aliasvalue(:off, :absent)

          newvalue(:present) do
              unless @resource.provider.exists?
                  @resource.provider.create
              end
          end
          aliasvalue(:on, :present)

      end

end
