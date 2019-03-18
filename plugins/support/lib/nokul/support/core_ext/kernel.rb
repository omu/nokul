# frozen_string_literal: true

require 'securerandom'

module Kernel
  module_function

  def secure_random_number(ceiling)
    SecureRandom.random_number(ceiling)
  end

  def secure_random_number_string(ceiling)
    format "%0#{ceiling.to_s.length}d", secure_random_number(ceiling)
  end

  def secure_random_number_extension(ceiling, separator: '.')
    separator + secure_random_number_string(ceiling)
  end
end
