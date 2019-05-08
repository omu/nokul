# frozen_string_literal: true

class Integer
  def to_string(length, base = 10)
    to_s(base).upcase.rjust(length, '0')
  end
end
