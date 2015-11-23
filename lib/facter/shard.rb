# shard.rb

require 'digest'

Facter.add('shard') do
confine :kernel => "Darwin"
    setcode do
        MOD_VALUE = 10000
        serial = Facter.value(:sp_serial_number)
        digest = Digest::SHA256.hexdigest serial
        sha256 = digest.to_i(16)
        shard = ((sha256 % MOD_VALUE) * 100) / MOD_VALUE.to_f
        shard.to_i
    end
end