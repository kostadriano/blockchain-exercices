require 'fileutils'
require 'openssl'
require 'base64'

class Parser
  RESULTS_FILE_PATH = 'results.txt'

  def initialize(private_keys:, messages:)
    @private_keys = private_keys
    @messages = messages
  end

  def parse_messages
    @private_keys.each do |pk_file|
      private_key = OpenSSL::PKey::RSA.new File.read pk_file

      write_messages_to_pv private_key
    end
  end

  private

  def write_messages_to_pv private_key
    @messages.map do |message_file|
      decoded_message = decode_message message_file

      decrypted_message = decrypt_message(private_key, decoded_message)

      write_message decrypted_message
    end
  end

  def decrypt_message(private_key, decoded_message)
    begin
      private_key.private_decrypt decoded_message
    rescue
      nil
    end
  end

  def decode_message encoded_message_file
    Base64.decode64(File.read encoded_message_file)
  end

  def write_message message
    File.write(RESULTS_FILE_PATH, message + "\n", mode: 'a') if message
  end
end
