require 'fileutils'
require_relative 'block.rb'

class BlockChain
  BLOCKS_FILES_NAMES = "blocks/block_*.txt"

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

    block = mount_block block_message

    file = File.open("blocks/block_#{persisted_blocks_length + 1}.txt", "w")

    file.puts(block)

    file.close
  end

  def get_previous_block_hash
    last_block_path = "blocks/block_#{persisted_blocks_length}.txt"

    return mount_previous_hash 'Vazio' unless File.exist? last_block_path

    file = File.open(last_block_path)
    content = file.read
    file.close

    previous_hash = content.scan(/Hash: (.*)\n/).first.first

    mount_previous_hash previous_hash
  end

  def mount_block block_message
    block_message + get_previous_block_hash
  end

  def mount_previous_hash hash
    "Hash Anterior: #{hash}"
  end

  def create_directory
    unless File.directory?('blocks')
      FileUtils.mkdir_p('blocks')
    end
  end
end
