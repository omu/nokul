# frozen_string_literal: true

require 'active_support'

class Encryptor
  def initialize(secret_key = rails_master_key)
    salt = SecureRandom.random_bytes(ActiveSupport::MessageEncryptor.key_len)
    passphrase = ActiveSupport::KeyGenerator.new(secret_key).generate_key(salt, 32)
    @encryptor = ActiveSupport::MessageEncryptor.new(passphrase)
  end

  def encrypt(data)
    File.open(Rails.root.join('db', 'encrypted_data', 'output.enc'), 'w') do |line|
      line.print @encryptor.encrypt_and_sign(data)
    end
  end

  def decrypt(data)
    @encryptor.decrypt_and_verify(data)
  end

  private

  def rails_master_key
    ENV['RAILS_MASTER_KEY'] || File.read(Rails.root.join('config', 'master.key'))
  rescue Errno::ENOENT => e
    abort("Master key not found! #{e}")
  end
end

# Jump to Rails console =>
# encryptor = Encryptor.new
# encrypted = encryptor.encrypt(File.read(Rails.root.join('db', 'static_data', 'districts.yml')))
# decrypted = encryptor.decrypt(File.read(Rails.root.join('db', 'encrypted_data', 'output.enc')))
# decrypted.split('\n').each do |line|
#   puts line
# end
