# frozen_string_literal: true

class ConcatenationError < StandardError
  def message
    I18n.t('errors.can_not_be_concatenated')
  end
end
