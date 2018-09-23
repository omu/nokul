# frozen_string_literal: true

require 'test_helper'

require 'fakefs/safe'

class EncryptedTest < ActiveSupport::TestCase
  PRISTINE_ROOT = Rails.configuration.x.encrypted.root
  PRISTINE_EXT  = Rails.configuration.x.encrypted.ext

  DEFAULT_ROOT  = Encrypted::File::DEFAULT_ROOT
  DEFAULT_EXT   = Encrypted::File::DEFAULT_EXT

  def teardown
    Rails.configuration.x.encrypted.root = PRISTINE_ROOT
    Rails.configuration.x.encrypted.ext  = PRISTINE_EXT
  end

  test 'default configuration should work' do
    file = 'ok'

    actual   = Encrypted::File.expand_path(file)
    expected = File.expand_path(DEFAULT_ROOT.join(file)) + DEFAULT_EXT
    assert_equal actual, expected
  end

  test 'set root path for encrypted files' do
    root = Rails.configuration.x.encrypted.root = Pathname.new '/tmp/root'
    file = 'ok'

    actual   = Encrypted::File.expand_path(file)
    expected = File.expand_path(root.join(file)) + DEFAULT_EXT
    assert_equal actual, expected
  end

  test 'set file extension for encrypted files' do
    ext  = Rails.configuration.x.encrypted.ext = ''
    file = 'ok'

    actual   = Encrypted::File.expand_path(file)
    expected = File.expand_path(DEFAULT_ROOT.join(file)) + ext
    assert_equal actual, expected
  end

  test 'leave absolute paths untouched' do
    file = '/tmp/ok'

    actual   = Encrypted::File.expand_path(file)
    expected = Pathname.new file
    assert_equal actual, expected
  end

  test 'test file existence' do
    plain = 'secret'
    file  = 'ok'

    FakeFS.with_fresh do
      Encrypted::File.write plain, file
      assert Encrypted::File.exist?(file)
    end
  end

  test 'encrypt text and then decrypt' do
    plain = 'secret'
    file  = 'ok'

    FakeFS.with_fresh do
      Encrypted::File.write plain, file
      assert_equal plain, Encrypted::File.read(file)
    end
  end

  test 'encrypt text and then decrypt while creating parent directories' do
    plain = 'secret'
    file  = 'a/b/c/ok'

    FakeFS.with_fresh do
      Encrypted::File.write plain, file
      assert_equal plain, Encrypted::File.read(file)
    end
  end

  test 'encrypt lines of text and then decrypt to lines' do
    plains = %w[this is pretty secret]
    file   = 'ok'

    FakeFS.with_fresh do
      Encrypted::File.writelines(plains, file)
      assert_same_elements plains, Encrypted::File.readlines(file)
    end
  end
end
