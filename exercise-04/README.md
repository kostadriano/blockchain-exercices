### ethereum-ruby

Para usar os contratos solidity com ruby tem a gem `ethereum-ruby`.
Usando a gem para utilizar um contrato:

```ruby
  client = Ethereum::IpcClient.new("ethereum_testnet/geth.ipc")

  init = Ethereum::Initializer.new("CheckPresence.sol", client)
  init.build_all

  check_presence_instance = SimpleNameRegistry.new('asd132a1', '05-05-2020')
  check_presence_instance.call_get_presence # "asd132a1 was here at 05-05-2020"
```
