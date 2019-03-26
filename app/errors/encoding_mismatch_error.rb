# frozen_string_literal: true

class EncodingMismatchError < StandardError
  def message
    I18n.t('errors.encoding_mismatch')
  end
end
