# frozen_string_literal: true

require 'securerandom'

module SecureRandom
  module_function

  def random_number_string(length)
    random_number(10**length).to_string(length, 10)
  end
end
