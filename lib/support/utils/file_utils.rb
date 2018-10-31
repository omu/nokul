# frozen_string_literal: true

module Support
  module_function

  def with_backup(new_file)
    raise ArgumentError, 'Block required' unless block_given?

    old_file = new_file + '.old'

    FileUtils.mv new_file, old_file if File.exist? new_file
    yield new_file

    success = File.exist? new_file
  ensure
    FileUtils.mv(old_file, new_file) unless success
  end

  def with_backup_and_notification(new_file, &block)
    new_file_exist_before = File.exist? new_file
    return unless with_backup(new_file, &block)

    old_file_exist = File.exist? old_file = new_file + '.old'

    return warn 'No change.' if old_file_exist && FileUtils.identical?(new_file, old_file)

    warn new_file_exist_before ? "#{new_file} updated due to the changes." : "#{new_file} created."

    warn "\nCompare with #{old_file}." if old_file_exist
  end
end
