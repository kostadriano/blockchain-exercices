require 'bitcoin'

Bitcoin.network = :testnet3
private_key, public_key = Bitcoin::generate_key
address = Bitcoin::pubkey_to_address(public_key)

puts('private key: ',private_key)
puts('public key: ',public_key)
puts('address: ', address)
