require 'rest-client'
require 'json'
require 'bitcoin'

include Bitcoin::Builder
Bitcoin.network = :testnet3

BITCOIN_TRANSACTIONS_PRIVATE_KEY = 'd97e0ddc261728eead60bfe1adc496bd4acbe876bf28c6c3d7177f8600348c5e'
BITCOIN_TRANSACTIONS_PUBLIC_KEY = '0428529de67881dfa74df7538f1670a5cb4aadd4e7dad4a4fed3c5e45efcdb7c330608e61815a60d4babed97c0b5bc1f23fff29ba27c4738c634016dadc2601f7b'
MY_ADDRESS = 'mxfcG5TNdS5RsUit4cfDSx32sQGdC6zqy1'
send_to_me = 50000 # 0.0005 BTC

faucet_address = 'mkHS9ne12qx9pS9VojpwU5xtRd4T7X7ZUt'

send_to = 'mr9xV9aNnfv6a1LhGsvVmFGW63Mn3ZwtJz'
send_value = 250000 # 0.0025 BTC

utxo = '047f52f37f8bb87a3334bae971a6be776fce526641736cae334a69449bdb76cd'
utxo_value = 1000000
utxo_index = 0

bitcoin_fee_per_byte = 46

key = Bitcoin::Key.new(BITCOIN_TRANSACTIONS_PRIVATE_KEY, BITCOIN_TRANSACTIONS_PUBLIC_KEY, opts={compressed: true})

response = RestClient.get("https://sochain.com/api/v2/get_tx/BTCTEST/#{utxo}")
parsed_response = JSON.parse(response)
prev_tx = Bitcoin::P::Tx.new(parsed_response['data']['tx_hex'])

new_tx = build_tx do |t|
  t.input do |i|
    i.prev_out prev_tx
    i.prev_out_index utxo_index
    i.signature_key key
  end

  t.output do |o|
    o.value send_value
    o.script { |s| s.type :address; s.recipient send_to }
  end

  t.output do |o|
    o.value send_to_me
    o.script { |s| s.type :address; s.recipient MY_ADDRESS }
  end

  t.output do |o|
    o.value utxo_value - send_value
    o.script { |s| s.type :address; s.recipient faucet_address }
  end
end

rawtx = new_tx.to_payload.unpack('H*').first
response = RestClient.post("https://sochain.com/api/v2/send_tx/BTCTEST", { tx_hex: rawtx })
puts JSON.parse(response)
