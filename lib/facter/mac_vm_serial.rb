#mac_vm_serial.rb
Facter.add(:mac_vm_serial) do
  confine :kernel => "Darwin"
  setcode do
    Facter.value('sp_serial_number').sub("+","").sub("/","")
  end
end
