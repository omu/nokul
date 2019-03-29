# frozen_string_literal: true

require 'test_helper'

require 'ostruct'

class HashTest < ActiveSupport::TestCase
  test 'to_deep_ostruct works' do
    hash = {
      first_level: {
        second_level: {
          second: 2
        },
        first: 1
      },
      top: 0
    }

    ostruct = hash.to_deep_ostruct

    assert ostruct.is_a? OpenStruct
    assert_equal 0, ostruct.top
    assert ostruct.first_level.is_a? OpenStruct
    assert_equal 1, ostruct.first_level.first
    assert ostruct.first_level.second_level.is_a? OpenStruct
    assert_equal 2, ostruct.first_level.second_level.second
  end
end
