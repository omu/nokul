# frozen_string_literal: true

class EncryptorService
  attr_reader :encryptor

  def initialize(salt, secret_key = Rails.application.credentials.dig(:secret_key_base))
    @encryptor = ActiveSupport::MessageEncryptor.new(
      key(secret_key, salt)
    )
  end

  class << self
    def encrypt(content, salt: '')
      new(salt).encryptor.encrypt_and_sign(content)
    end

    def decrypt(encrypted_data, salt: '')
      new(salt).encryptor.decrypt_and_verify(encrypted_data)
    end
  end

  private

  def key(secret_key, salt, length: 32)
    @key ||= ActiveSupport::KeyGenerator.new(secret_key).generate_key(salt, length)
  end
end
