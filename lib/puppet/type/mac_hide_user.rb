Puppet::Type.newtype(:mac_hide_user) do
  @doc = "Hides a user from the OS X login window"

  newparam(:name, :namevar => true)

  ensurable do
          desc "Possible values are *true* and *false*"

          newvalue(:absent) do
              if @resource.provider.exists?
                  @resource.provider.destroy
              end
          end
          aliasvalue(:false, :absent)

          newvalue(:present) do
              unless @resource.provider.exists?
                  @resource.provider.create
              end
          end
          aliasvalue(:true, :present)
      end

end
