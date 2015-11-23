# shard.rb

require 'digest'

Facter.add('shard') do
confine :kernel => "Darwin"
    setcode do
        if File.exist?('/usr/local/shard/production')
            100
        elsif File.exist?('/usr/local/shard/testing')
            1
        else                
            MOD_VALUE = 10000
            serial = Facter.value(:sp_serial_number)
            digest = Digest::SHA256.hexdigest serial
            sha256 = digest.to_i(16)
            shard = ((sha256 % MOD_VALUE) * 100) / MOD_VALUE.to_f
            shard.to_i
        end
    end
end