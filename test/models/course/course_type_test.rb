# frozen_string_literal: true

require 'test_helper'

class CourseTypeTest < ActiveSupport::TestCase
  setup do
    @course_type = course_types(:internship)
  end

  # relations
  test 'a course type can communicate with courses' do
    assert @course_type.courses
  end

  # validations: presence
  %i[
    name
    code
    min_credit
  ].each do |property|
    test "presence validations for #{property} of a course type" do
      @course_type.send("#{property}=", nil)
      assert_not @course_type.valid?
      assert_not_empty @course_type.errors[property]
    end
  end

  # validations: uniqueness
  %i[
    name
    code
  ].each do |property|
    test "uniqueness validations for #{property} of a course type" do
      fake = @course_type.dup
      assert_not fake.valid?
      assert_not_empty fake.errors[property]
    end
  end

  # validations: numericality
  test 'presence numericality for min_credit of a course type' do
    @course_type.min_credit = -1
    assert_not @course_type.valid?
    assert_not_empty @course_type.errors[:min_credit]
  end
end
