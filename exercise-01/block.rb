require 'digest'

class Block
  MESSAGE = "Origem: {sender}\nDestino: {recipient}\nMensagem: Ola {recipient}. Meu nome é {sender}.\n"

  attr_reader :hash, :message

  def initialize(sender:, recipient:)
    @sender=sender
    @recipient=recipient
    @message=mount_message
    @hash=get_block_hash
  end

  private

  def mount_message
    MESSAGE.gsub(/{recipient}/, @recipient).gsub(/{sender}/, @sender)
  end

  def get_block_hash
    Digest::SHA256.hexdigest @message
  end
end
