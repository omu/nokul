# frozen_string_literal: true

require 'test_helper'

class PositionTest < ActiveSupport::TestCase
  # relations
  %i[
    duty
    administrative_function
  ].each do |property|
    test "an identity can communicate with #{property}" do
      assert positions(:baum_dean).send(property)
    end
  end

  # validations: presence
  %i[
    start_date
  ].each do |property|
    test "presence validations for #{property} of a position" do
      positions(:baum_dean).send("#{property}=", nil)
      assert_not positions(:baum_dean).valid?
      assert_not_empty positions(:baum_dean).errors[property]
    end
  end

  # validations: uniqueness
  test 'a user can not have duplicate positions in a department' do
    fake = positions(:baum_dean).dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:duty]
  end
end
