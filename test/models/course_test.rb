# frozen_string_literal: true

require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  include AssociationTestModule
  include ValidationTestModule

  setup do
    @course = courses(:test)
  end

  # relations
  belongs_to :course_type
  belongs_to :unit
  belongs_to :language

  # validations: presence
  validates_presence_of :code
  validates_presence_of :course_type
  validates_presence_of :program_type
  validates_presence_of :laboratory
  validates_presence_of :language
  validates_presence_of :name
  validates_presence_of :practice
  validates_presence_of :status
  validates_presence_of :theoric
  validates_presence_of :unit

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
