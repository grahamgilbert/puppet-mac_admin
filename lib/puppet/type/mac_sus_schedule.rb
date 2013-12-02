Puppet::Type.newtype(:mac_sus_schedule) do
  @doc = "Enables and disables automatic software update checks"
  
  ensurable
  
  newparam(:name, :namevar => true)
  
end