# frozen_string_literal: true

class IdNumberError < StandardError
  def message
    # TODO: i18n
    'Invalid or temporary ID number!'
  end
end
