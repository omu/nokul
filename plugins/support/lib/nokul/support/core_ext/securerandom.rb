# frozen_string_literal: true

require 'securerandom'

module SecureRandom
  module_function

  def random_number_string(length, base = 10)
    random_number(base**length).to_string(length, base)
  end
end
