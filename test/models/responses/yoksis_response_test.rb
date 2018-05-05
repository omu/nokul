# frozen_string_literal: true

require 'test_helper'

class YoksisResponseTest < ActiveSupport::TestCase
  # validation tests for presence
  test 'presence validations for name of a yoksis_response' do
    yoksis_responses(:response_1).name = nil
    refute yoksis_responses(:response_1).valid?
    assert_not_nil yoksis_responses(:response_1).errors[:name]
  end

  test 'presence validations for endpoint of a yoksis_response' do
    yoksis_responses(:response_1).endpoint = nil
    refute yoksis_responses(:response_1).valid?
    assert_not_nil yoksis_responses(:response_1).errors[:endpoint]
  end

  test 'presence validations for action of a yoksis_response' do
    yoksis_responses(:response_1).action = nil
    refute yoksis_responses(:response_1).valid?
    assert_not_nil yoksis_responses(:response_1).errors[:action]
  end

  test 'presence validations for sha1 of a yoksis_response' do
    yoksis_responses(:response_1).sha1 = nil
    refute yoksis_responses(:response_1).valid?
    assert_not_nil yoksis_responses(:response_1).errors[:sha1]
  end

  # validation tests for uniqueness
  test 'uniqueness validations for yoksis_response' do
    fake = yoksis_responses(:response_1).dup
    refute fake.valid?
  end

  test 'uniqueness validations for sha1 field of a unit' do
    fake = yoksis_responses(:response_1).dup
    assert_not_nil fake.errors[:sha1]
  end
end
