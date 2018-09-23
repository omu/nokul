# frozen_string_literal: true

require 'singleton'
require 'pathname'
require 'fileutils'

require 'active_support'

# Encryption stuff
module Encrypted
  CONFIGURATION = Rails.configuration.x.encrypted

  # MessageEncryptor wrapper using Rails master key as the default secret key
  class Encryptor
    include Singleton # no need to create a new encryptor each time, hence a singleton

    def initialize(secret_key = rails_master_key)
      salt = SecureRandom.random_bytes(ActiveSupport::MessageEncryptor.key_len)
      passphrase = ActiveSupport::KeyGenerator.new(secret_key).generate_key(salt, 32)
      @encryptor = ActiveSupport::MessageEncryptor.new(passphrase)
    end

    def encrypt(data)
      encryptor.encrypt_and_sign(data)
    end

    def decrypt(data)
      encryptor.decrypt_and_verify(data)
    end

    protected

    attr_reader :encryptor

    def rails_master_key
      ENV['RAILS_MASTER_KEY'] || File.read(Rails.root.join('config', 'master.key'))
    rescue Errno::ENOENT => err
      abort("Master key not found! #{err}")
    end
  end

  def self.encryptor
    Encryptor.instance
  end

  # Mimics File module to support encrypted files transparently
  module File
    DEFAULT_ROOT = Rails.root
    DEFAULT_EXT  = '.enc'

    def self.root
      return DEFAULT_ROOT unless (root = CONFIGURATION.root)

      Pathname.new ::File.expand_path(root, Rails.root)
    end

    def self.ext
      CONFIGURATION.ext || DEFAULT_EXT
    end

    def self.expand_path(pathname)
      pathname = Pathname.new(pathname)
      return pathname if pathname.absolute?

      ::File.expand_path root.join("#{pathname}#{ext}")
    end

    def self.read(pathname)
      Encryptor.instance.decrypt(::File.read(expand_path(pathname)))
    end

    def self.readlines(pathname)
      read(pathname).split "\n"
    end

    def self.write(content, pathname)
      file = expand_path(pathname)
      unless Dir.exist?(dir = ::File.dirname(file))
        FileUtils.mkdir_p(dir)
      end
      ::File.write(file, Encryptor.instance.encrypt(content))
    end

    def self.writelines(lines, pathname)
      write(lines.join("\n"), pathname)
    end

    def self.exist?(pathname)
      ::File.exist?(expand_path(pathname))
    end
  end
end
