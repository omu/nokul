# frozen_string_literal: true

require 'test_helper'

class SecureRandomTest < ActiveSupport::TestCase
  test 'random_number_string works' do
    assert_match(/^\d{4}$/, SecureRandom.random_number_string(4))
  end
end
