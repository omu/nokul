# frozen_string_literal: true

require 'test_helper'

class EmployeeTest < ActiveSupport::TestCase
  # relations
  %i[
    user
    title
    duties
    units
  ].each do |property|
    test "an employee can communicate with #{property}" do
      assert employees(:serhat).send(property)
    end
  end

  # validations: presence
  %i[
    title
    user
  ].each do |property|
    test "presence validations for #{property} of an employee" do
      employees(:serhat).send("#{property}=", nil)
      assert_not employees(:serhat).valid?
      assert_not_empty employees(:serhat).errors[property]
    end
  end

  # validations: uniqueness
  test 'a user can only have an employee' do
    fake = employees(:serhat).dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:user]
  end
end
