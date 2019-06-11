# frozen_string_literal: true

class ImageValidator < ActiveModel::Validator
  MINIMUM_FILE_SIZE = 1024 # 1KB
  MAXIMUM_FILE_SIZE = 3_145_728 # 3MB

  def validate(record)
    @record = record
    @avatar = record.avatar.blob
    restrict_format(@avatar.content_type) unless whitelist.include?(@avatar.content_type)
    raise_file_size_error unless size_limits(@avatar)
  end

  private

  def whitelist
    %w[image/jpg image/jpeg image/png]
  end

  def size_limits(file)
    file.byte_size.between?(MINIMUM_FILE_SIZE, MAXIMUM_FILE_SIZE)
  end

  def restrict_format(mime_type)
    extension_whitelist = whitelist.map { |f| f.split('/').last }.join(', ')
    @record.errors[:base] << I18n.t(
      'not_permitted',
      mime_type:           mime_type,
      extension_whitelist: extension_whitelist,
      scope:               %I[validators image]
    ) && teardown
  end

  def raise_file_size_error
    @record.errors[:base] << I18n.t(
      'size_not_satisfied',
      minimum: MINIMUM_FILE_SIZE / 1024,
      maximum: MAXIMUM_FILE_SIZE / (1024 * 1024),
      scope:   %I[validators image]
    ) && teardown
  end

  def teardown
    @record.avatar.purge
  end
end
