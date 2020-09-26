require 'fileutils'
require_relative 'block'
require_relative 'hash'

class BlockChain
  BLOCKS_FILES_NAMES = "blocks/block_*.txt"

  def validate_blockchain
    last_block_number = persisted_blocks_length
    last_block_path = get_file_path last_block_number

    while(File.exist? last_block_path)
      block = deserialize_block(read_file_content(last_block_path))

      new_generated_hash = Hash.generate block[:content]

      raise raise_block_error(last_block_path) if new_generated_hash.strip != block[:hash].strip

      last_block_number -= 1
      last_block_path = get_file_path last_block_number

      if File.exist? last_block_path
        last_block = deserialize_block(read_file_content(last_block_path))

        raise raise_block_error(last_block_path) if block[:previous_hash] != last_block[:hash]
      end
    end

    true
  end

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

    validate_blockchain

    block = mount_block block_message

    file = File.open(get_file_path(persisted_blocks_length + 1), "w")

    file.puts(block)

    file.close
  end

  def get_previous_block_hash
    last_block_path = get_file_path persisted_blocks_length

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

  def get_file_path block_number
    "blocks/block_#{block_number}.txt"
  end

  def deserialize_block content
    content.match(/(?<content>.*)Hash: (?<hash>.*)Hash Anterior: (?<previous_hash>.*)/m)
  end

  def read_file_content file_path
    file = File.open(file_path)
    content = file.read
    file.close

    return content
  end

  def raise_block_error block
    raise "Invalid hash on #{block}"
  end
end
