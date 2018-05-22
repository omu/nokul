# frozen_string_literal: true

require 'test_helper'

class YoksisResponseTest < ActiveSupport::TestCase
  # validations: presence
  %i[
    name
    endpoint
    action
    sha1
  ].each do |property|
    test "presence validations for #{property} of a yoksis_response" do
      yoksis_responses(:response_1).send("#{property}=", nil)
      assert_not yoksis_responses(:response_1).valid?
      assert_not_empty yoksis_responses(:response_1).errors[property]
    end
  end

  # validations: uniqueness
  test 'uniqueness validations for sha1 field of a unit' do
    fake = yoksis_responses(:response_1).dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:sha1]
  end
end
