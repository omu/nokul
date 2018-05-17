# frozen_string_literal: true

require 'test_helper'

class YoksisResponseTest < ActiveSupport::TestCase
  # validation tests for the presence of listed properties
  %i[
    name
    endpoint
    action
    sha1
  ].each do |property|
    test "presence validations for #{property} of a yoksis_response" do
      yoksis_responses(:response_1).send("#{property}=", nil)
      refute yoksis_responses(:response_1).valid?
      refute_empty yoksis_responses(:response_1).errors[property]
    end
  end

  # validation tests for uniqueness
  test 'uniqueness validations for sha1 field of a unit' do
    fake = yoksis_responses(:response_1).dup
    refute fake.valid?
    refute_empty fake.errors[:sha1]
  end
end
