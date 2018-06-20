# frozen_string_literal: true

require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  test 'course can communicate with unit' do
    assert courses(:ati).unit
  end

  # validations: presence
  %i[
    code
    education_type
    laboratory
    language
    name
    practice
    status
    theoric
  ].each do |property|
    test "presence validations for #{property} of a course" do
      courses(:ati).send("#{property}=", nil)
      assert_not courses(:ati).valid?
      assert_not_empty courses(:ati).errors[property]
    end
  end

  test 'presence validations for abrogated_date of a course' do
    courses(:fi_tarihi).abrogated_date = nil
    assert_not courses(:fi_tarihi).valid?
    assert_not_empty courses(:fi_tarihi).errors[:abrogated_date]
  end

  # validations: uniqueness
  test 'uniqueness validations for code of a course' do
    fake = courses(:ati).dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:code]
  end

  test 'uniqueness validations for name of a course' do
    fake = courses(:ati).dup
    assert_not fake.valid?
    fake.code = 'TEST001'
    assert fake.valid?
  end

  # callbacks
  test 'callbacks must titlecase the name for a course' do
    course = courses(:test).dup
    course.update(code: 'DD101', name: 'deNEme dErSi')
    assert_equal course.name, 'Deneme Dersi'
  end

  test 'callbacks must set value the abrogated date for a course' do
    course = courses(:test).dup
    course.update(code: 'DD101', status: :abrogated)
    assert_equal course.abrogated_date, Time.zone.today
  end

  test 'callbacks must set value the credit for a course' do
    course = courses(:test).dup
    course.update(code: 'DD101', theoric: 10, practice: 3)
    assert_equal course.credit, 11.5
  end

  # enums
  {
    status: { passive: 0, active: 1, abrogated: 2 },
    education_type: { undergraduate: 0, master: 1, doctoral: 2 }
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
    assert_equal course.calculate_credit, 9.5
  end
end
