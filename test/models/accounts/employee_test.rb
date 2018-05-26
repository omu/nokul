# frozen_string_literal: true

require 'test_helper'

class EmployeeTest < ActiveSupport::TestCase
  # relations
  %i[
    user
    title
    duties
    units
    positions
    administrative_functions
  ].each do |property|
    test "an employee can communicate with #{property}" do
      assert employees(:serhat).send(property)
    end
  end

  # validations: presence
  %i[
    active
  ].each do |property|
    test "presence validations for #{property} of an employee" do
      employees(:serhat).send("#{property}=", nil)
      assert_not employees(:serhat).valid?
      assert_not_empty employees(:serhat).errors[property]
    end
  end
end
