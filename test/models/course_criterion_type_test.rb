# frozen_string_literal: true

require 'test_helper'

class CourseCriterionTypeTest < ActiveSupport::TestCase
  setup do
    @criterion_type = course_criterion_types(:exam)
  end

  # validations: presence
  %i[
    name
    identifier
  ].each do |property|
    test "presence validations for #{property} of a course criterion type" do
      @criterion_type.send("#{property}=", nil)
      assert_not @criterion_type.valid?
      assert_not_empty @criterion_type.errors[property]
    end
  end

  # validations: uniqueness
  %i[
    name
    identifier
  ].each do |property|
    test "uniqueness validations for #{property} of a course criterion type" do
      fake = @criterion_type.dup
      assert_not fake.valid?
      assert_not_empty fake.errors[property]
    end
  end

  # callbacks
  test 'callbacks must titlecase the name of a course criterion type' do
    criterion_type = CourseCriterionType.create!(name: 'Test criTErion', identifier: 'test')
    assert_equal criterion_type.name, 'Test Criterion'
  end
end
