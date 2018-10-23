# frozen_string_literal: true

require 'test_helper'

class FileEncryptorTest < ActiveSupport::TestCase
  test 'makes sure ActiveSupport::EncryptedFile is reachable' do
    assert ActiveSupport::EncryptedFile.respond_to?('new')
  end

  test 'can initialize an ActiveSupport::EncryptedFile object with default params' do
    object = ActiveSupport::EncryptedFile.new(
      FileEncryptor::DEFAULT_PARAMS.merge(content_path: '')
    )
    assert_equal object.class, ActiveSupport::EncryptedFile
  end

  test 'can encrypt a plain-text file' do
    assert_difference("Dir[File.join('db/encrypted_data', '*')].count { |file| File.file?(file) }") do
      FileEncryptor.encrypt(file_fixture('plain_text.csv').to_s)
    end
    File.delete('db/encrypted_data/plain_text.csv.enc') if File.exist?('db/encrypted_data/plain_text.csv.enc')
  end

  test 'can decrypt an encrypted file' do
    assert_equal "12345678912|Mustafa Serhat|Dündar|123456\n98765432198|Recai|Oktaş|987654",
                 FileEncryptor.decrypt(file_fixture('encrypted.csv.enc').to_s)
  end

  test 'can decrypt an encrypted file as array' do
    assert_equal 2, FileEncryptor.decrypt_lines(file_fixture('encrypted.csv.enc').to_s).count
  end
end
