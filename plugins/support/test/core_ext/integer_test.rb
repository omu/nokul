# frozen_string_literal: true

require 'test_helper'

class IntegerTest < ActiveSupport::TestCase
  test 'to_string works' do
    assert_equal '0011', 17.to_string(4, 16)
  end
end
