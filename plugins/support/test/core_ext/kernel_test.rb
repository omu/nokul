# frozen_string_literal: true

require 'test_helper'

class KernelTest < ActiveSupport::TestCase
  test 'secure_random_number_string works' do
    assert_match(/^\d{4}$/, secure_random_number_string(9999))
  end

  test 'secure_random_number_extension works' do
    assert_match(/^_\d{4}$/, secure_random_number_extension(9999, separator: '_'))
  end
end
