# frozen_string_literal: true

class UnicodeSupportError < StandardError
  def message
    I18n.t('errors.unicode_not_supported')
  end
end
