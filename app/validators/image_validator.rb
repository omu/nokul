# frozen_string_literal: true

class ImageValidator < ActiveModel::Validator
  def validate(record)
    @record = record
    restrict(@record.avatar.filename.extension_without_delimiter) unless whitelist.include?(@record.avatar.content_type)
  end

  private

  def whitelist
    %w[image/jpg image/jpeg image/png]
  end

  def restrict(mime_type)
    extension_whitelist = whitelist.map { |f| f.split('/').last }.join(', ')
    @record.errors[:base] << I18n.t(
      'not_permitted',
      mime_type: mime_type,
      extension_whitelist: extension_whitelist,
      scope: %I[validators image]
    )
  end
end
