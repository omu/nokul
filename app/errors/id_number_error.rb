# frozen_string_literal: true

class IdNumberError < StandardError
  def message
    I18n.t('errors.invalid_id')
  end
end
