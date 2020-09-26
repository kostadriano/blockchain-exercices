require 'digest'

class Block
  MESSAGE = "Origem: {sender}\nDestino: {recipient}\nMensagem: Ola {recipient}. Meu nome é {sender}.\n"
  BLOCK_STRUCTURE = "{message}Hash: {hash}\n"

  def initialize(sender:, recipient:)
    @sender=sender
    @recipient=recipient
  end

  def get_block
    BLOCK_STRUCTURE.gsub(/{message}/,message).gsub(/{hash}/, hash)
  end

  private

  def message
    MESSAGE.gsub(/{recipient}/, @recipient).gsub(/{sender}/, @sender)
  end

  def hash
    Digest::SHA256.hexdigest message
  end
end
