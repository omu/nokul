# frozen_string_literal: true

class FileEncryptor
  DEFAULT_PARAMS = {
    env_key: 'RAILS_MASTER_KEY',
    key_path: Rails.root.join('config', 'master.key'),
    raise_if_missing_key: true
  }.freeze

  def self.encrypt(path)
    encryptor = ActiveSupport::EncryptedFile.new(
      merge_with_content_path(Rails.root.join('db', 'encrypted_data', path.split('/').last + '.enc'))
    )

    encryptor.write(File.read(Rails.root.join(path)))
  end

  def self.decrypt(path)
    encryptor = ActiveSupport::EncryptedFile.new(
      merge_with_content_path(Rails.root.join(path))
    )

    encryptor.read
  end

  def self.decrypt_lines(path)
    encryptor = ActiveSupport::EncryptedFile.new(
      merge_with_content_path(Rails.root.join(path))
    )

    encryptor.read.split("\n")
  end

  def self.merge_with_content_path(value)
    DEFAULT_PARAMS.merge(
      content_path: value
    )
  end
end
