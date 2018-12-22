# frozen_string_literal: true

require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  setup do
    @course = courses(:test)
  end

  %i[
    course_type
    unit
    language
  ].each do |property|
    test "course can communicate with #{property}" do
      assert @course.send(property)
    end
  end

  # validations: presence
  %i[
    code
    course_type
    program_type
    laboratory
    language
    name
    practice
    status
    theoric
    unit
  ].each do |property|
    test "presence validations for #{property} of a course" do
      @course.send("#{property}=", nil)
      assert_not @course.valid?
      assert_not_empty @course.errors[property]
    end
  end

  # validations: uniqueness
  test 'uniqueness validations for code of a course' do
    fake = @course.dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:code]
  end

  test 'uniqueness validations for name of a course' do
    fake = @course.dup
    fake.code = 'TB01'
    assert_not fake.valid?
    assert_not_empty fake.errors[:name]
  end

  # callbacks
  test 'callbacks must titlecase the name for a course' do
    course = @course.dup
    course.update(code: 'DD101', name: 'deNEme dErSi')
    assert_equal course.name, 'Deneme Dersi'
  end

  test 'callbacks must set value the credit for a course' do
    course = @course.dup
    course.update(code: 'DD101', theoric: 10, practice: 3)
    assert_equal course.credit, 11.5
  end

  # enums
  {
    status: { passive: 0, active: 1 },
    program_type: { associate: 0, undergraduate: 1, master: 2, doctoral: 3 }
  }.each do |property, hash|
    hash.each do |key, value|
      test "have a #{key} value of #{property} enum" do
        enums = Course.defined_enums.with_indifferent_access
        assert_equal enums.dig(property, key), value
      end
    end
  end

  # actions
  test '#calculate_credit' do
    course = courses(:test)
    course.theoric = 8
    course.practice = 3
    course.laboratory = 4
    assert_equal course.calculate_credit, 11.5
  end
end
