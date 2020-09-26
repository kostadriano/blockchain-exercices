require_relative 'block.rb'

class BlockChain
  def create_block(sender:, recipient:)
    Block.new(sender: sender, recipient: recipient)
  end
end
