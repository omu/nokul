# frozen_string_literal: true

class IdNumberError < StandardError
  def message
    'Invalid or temporary ID number!'
  end
end
