### Usage

Para rodar: `ruby main.rb`, isso vai utilizar das chaves privadas e das mensagens que estao na pasta `files`.

Para testar com outros arquivos diferentes basta abrir com o irb, fazer um require do parser:

`require_relative 'parser'`

Criar uma instancia do parser passando os paths dos arquivos das chaves privadas e das mensagens:

`parse = Parser.new(private_keys: ['pv1.txt'], messages: ['msg1.txt'])`

E chamar o metodo `parse_messages` desta instancia:

`parse.parse_messages`
