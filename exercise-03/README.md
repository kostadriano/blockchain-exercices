## Geração da cateira
`ruby generate_wallet.rb`

* privateKey: `d97e0ddc261728eead60bfe1adc496bd4acbe876bf28c6c3d7177f8600348c5e`
* publicKey: `0428529de67881dfa74df7538f1670a5cb4aadd4e7dad4a4fed3c5e45efcdb7c330608e61815a60d4babed97c0b5bc1f23fff29ba27c4738c634016dadc2601f7b`
* address: `mxfcG5TNdS5RsUit4cfDSx32sQGdC6zqy1`

## Depósito:
Para o despósito foi utilizado o `https://testnet-faucet.mempool.co`

* Resumo do depósito:
```
Transaction sent

TxID: 047f52f37f8bb87a3334bae971a6be776fce526641736cae334a69449bdb76cd
Address: mxfcG5TNdS5RsUit4cfDSx32sQGdC6zqy1
Amount: 0.01
Give back \ Donate tBTC: mkHS9ne12qx9pS9VojpwU5xtRd4T7X7ZUt
```

```json
{
  "status" : "success",
  "data" : {
    "network" : "BTCTEST",
    "address" : "mxfcG5TNdS5RsUit4cfDSx32sQGdC6zqy1",
    "txs" : [
      {
        "txid" : "047f52f37f8bb87a3334bae971a6be776fce526641736cae334a69449bdb76cd",
        "output_no" : 0,
        "script_asm" : "OP_DUP OP_HASH160 bc1d288b546086c4db036149d42530825c621155 OP_EQUALVERIFY OP_CHECKSIG",
        "script_hex" : "76a914bc1d288b546086c4db036149d42530825c62115588ac",
        "value" : "0.01000000",
        "confirmations" : 9,
        "time" : 1601152626
      }
    ]
  }
}
```

## Transação
Após isso usei o arquivo send_bitcoin pra fazer a transação, nele salvei:

* Minha chave publica, privada e endereço da carteira
* Coloquei o endereço de envio e a quantidade de btc em satoshi
* coloquei o txid da transação acima, o valor dela e o index 0 por se a unica
* consultei a taxa de transação no site e adicionei para "fast"
* utilizei dos metodos para montar a chave e fazer a request para pegar a ultima transação
* salvei o endereço da carteira do faucet para fazer as transações de volta
* montei o bloco com a entrada e saidas, e a requisição para o sochain.

> PORÉM aqui deu a merda

mudei varias vezes e varias configurações mas toda vez cai nesse erro:

```ruby
ruby send_bitcoin.rb
Traceback (most recent call last):
	5: from send_bitcoin.rb:30:in `<main>'
	4: from /home/adriano/.rvm/gems/ruby-2.7.1/gems/bitcoin-ruby-0.0.20/lib/bitcoin/builder.rb:20:in `build_tx'
	3: from send_bitcoin.rb:31:in `block in <main>'
	2: from /home/adriano/.rvm/gems/ruby-2.7.1/gems/bitcoin-ruby-0.0.20/lib/bitcoin/builder.rb:158:in `input'
	1: from send_bitcoin.rb:33:in `block (2 levels) in <main>'
/home/adriano/.rvm/gems/ruby-2.7.1/gems/bitcoin-ruby-0.0.20/lib/bitcoin/builder.rb:401:in `prev_out_index': undefined method `pk_script' for nil:NilClass (NoMethodError)
Did you mean?  script
```

Pelo jeito esta acontecendo nesta linha `i.prev_out prev_tx`, quando eu comento ele passa dessa parte, porem o hexadecimal gerado é invalido, e a transação falha (tentei utilizando o curl no terminal passando o hex geardo pelo código).

```
curl -H "Content-Type: application/json" -X POST -d '{"tx_hex":"010000000100000000000000000000000000000000000000000000000000000000000000000000000000ffffffff0390d00300000000001976a91474b0cedfcbc42c94c074433084a1eccda938eb0f88ac50c30000000000001976a914bc1d288b546086c4db036149d42530825c62115588acb0710b00000000001976a914344a0f48ca150ec2b903817660b9b68b13a6702688ac00000000"}' https://sochain.com/api/v2/send_tx/BTCTEST
{
  "status" : "fail",
  "data" : {
    "network" : "Network is required (DOGE, DOGETEST, ...)",
    "tx_hex" : "A valid signed transaction hexadecimal string is required. Please check if all inputs in the given transactions are still available to spend. See the \"Is Tx Output Spent?\" API call for reference."
  }
}
```
