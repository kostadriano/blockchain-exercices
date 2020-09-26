require 'fileutils'
require_relative 'block.rb'

class BlockChain
  BLOCKS_FILES_NAMES = "blocks/block*.txt"

  def create_block(sender:, recipient:)
    Block.new(sender: sender, recipient: recipient)
  end

  def add_block block
    persist block.get_block
  end

  private

  def persisted_blocks_length
    Dir[BLOCKS_FILES_NAMES].length
  end

  def persist block_message
    create_directory

    file = File.open("blocks/block_#{persisted_blocks_length + 1}.txt", "w")

    file.puts(block_message)
  end

  def create_directory
    unless File.directory?('blocks')
      FileUtils.mkdir_p('blocks')
    end
  end
end
