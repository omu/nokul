# frozen_string_literal: true

require 'test_helper'

class SdpCodeTest < ActiveSupport::TestCase
  test 'full_code must return the full of standardized sdp code' do
    sdp_code_one = sdp_codes(:one)
    sdp_code_two = sdp_codes(:two)

    assert_equal sdp_code_one.full_code, '010.01.99'
    assert_equal sdp_code_two.full_code, '045.99.00'
  end
end
