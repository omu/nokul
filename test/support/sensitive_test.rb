# frozen_string_literal: true

require 'test_helper'

class SensitiveTest < ActiveSupport::TestCase
  setup do
    @content = "12345678912|Mustafa Serhat|Dündar|123456\n98765432198|Recai|Oktaş|987654"
  end

  test 'makes sure ActiveSupport::EncryptedFile is reachable' do
    assert ActiveSupport::EncryptedFile.respond_to?('new')
  end

  test 'read method must decrypt an encrypted file' do
    decrypted_content = Sensitive.read(
      Rails.root.join('test', 'fixtures', 'files', 'encrypted.csv')
    )
    assert decrypted_content, @content
  end

  test 'readlines method must decrypt an encrypted file and read in multiline' do
    decrypted_content = Sensitive.readlines(
      Rails.root.join('test', 'fixtures', 'files', 'encrypted.csv')
    )
    assert decrypted_content, @content.split("\n")
  end

  test 'write method must encrypt plain-text content' do
    Dir.mktmpdir do |dir|
      assert_difference("Dir[File.join(dir, '*.enc')].count") do
        Sensitive.write(File.join(dir, 'test'), @content)
      end
    end
  end

  test 'writelines method must encrypt multiline content' do
    Dir.mktmpdir do |dir|
      assert_difference("Dir[File.join(dir, '*.enc')].count") do
        Sensitive.writelines(File.join(dir, 'multilines'), @content.split("\n"))
      end
    end
  end

  test 'read_write method must read the raw file and must write be encrypted' do
    Dir.mktmpdir do |dir|
      File.write("#{dir}/plain.csv", @content)
      assert_difference("Dir[File.join(dir, '*.enc')].count") do
        Sensitive.read_write(File.join(dir, 'plain.csv'))
      end
    end
  end

  test 'encryptor must an instance of ActiveSupport::EncryptedFile' do
    encryptor = Sensitive.encryptor('/foo')
    assert encryptor.is_a? ActiveSupport::EncryptedFile
    assert_equal encryptor.content_path, Pathname.new('/foo')
  end

  test 'expand_path' do
    path = Sensitive.expand_path('/foo')
    assert_equal path, '/foo.enc'
  end
end
