# frozen_string_literal: true

require 'test_helper'

class SdpCodeTest < ActiveSupport::TestCase
  test 'full_code must return the full of standardized sdp code' do
    sdp_code_one = sdp_codes(:one)
    sdp_code_two = sdp_codes(:two)

    assert_equal('010.01.99', sdp_code_one.full_code)
    assert_equal('045.99.00', sdp_code_two.full_code)
  end
end
