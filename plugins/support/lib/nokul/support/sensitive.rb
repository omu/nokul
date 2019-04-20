# frozen_string_literal: true

require 'fileutils'

module Nokul
  module Support
    # Sensitive file read/write
    module Sensitive
      module_function

      def read(path)
        encryptor(expand_path(path)).read
      end

      def readlines(path)
        read(path).split "\n"
      end

      def write(path, content)
        unless Dir.exist?(dir = File.dirname(file = expand_path(path)))
          FileUtils.mkdir_p(dir)
        end
        encryptor(file).write(content)
      end

      def writelines(path, contents)
        write(path, contents.join("\n"))
      end

      def read_write(path)
        write(path, File.read(path))
      end

      def content_decrypt(content)
        encryptor('').send(:decrypt, content)
      end

      EXT = '.enc'

      def expand_path(path)
        File.expand_path(path, Rails.root) + EXT
      end

      def encryptor(file)
        ActiveSupport::EncryptedFile.new(
          content_path: file,
          env_key: 'RAILS_MASTER_KEY',
          key_path: Rails.root.join('config', 'master.key'),
          raise_if_missing_key: true
        )
      end
    end
  end
end
