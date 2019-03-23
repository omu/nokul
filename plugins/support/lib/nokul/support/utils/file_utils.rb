# frozen_string_literal: true

require 'digest/md5'

module Nokul
  module Support
    module_function

    def with_backup(new_file)
      raise ArgumentError, 'Block required' unless block_given?

      old_file = "#{new_file}.old"

      FileUtils.mv new_file, old_file if File.exist? new_file
      yield new_file

      success = File.exist? new_file
    ensure
      FileUtils.mv(old_file, new_file) unless success
    end

    def with_backup_and_notification(new_file, &block)
      new_file_exist_before = File.exist? new_file
      return unless with_backup(new_file, &block)

      old_file_exist = File.exist? old_file = "#{new_file}.old"

      return warn 'No change.' if old_file_exist && FileUtils.identical?(new_file, old_file)

      warn new_file_exist_before ? "#{new_file} updated due to the changes." : "#{new_file} created."

      warn "\nCompare with #{old_file}." if old_file_exist
    end

    def with_status(new_file)
      raise ArgumentError, 'Block required' unless block_given?

      old_checksum = Digest::MD5.hexdigest(File.read(new_file)) if File.exist? new_file
      yield new_file
      new_checksum =  Digest::MD5.hexdigest(File.read(new_file)) if File.exist? new_file

      old_checksum != new_checksum
    end

    def with_status_and_notification(new_file, &block)
      new_file_exist_before = File.exist? new_file

      if (status = with_status(new_file, &block))
        warn new_file_exist_before ? "#{new_file} updated due to the changes." : "#{new_file} created."
      else
        warn 'No change.'
      end

      status
    end
  end
end
