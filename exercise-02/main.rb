require_relative 'parser'

private_keys = Dir["files/PrivateKeys/*"]
messages = Dir["files/Messages/*"]

parse = Parser.new(private_keys: private_keys, messages: messages)

parse.parse_messages
