# frozen_string_literal: true

require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  include AssociationTestModule
  include CallbackTestModule
  include EnumerationTestModule
  include ValidationTestModule

  setup do
    @course = courses(:test)
  end

  # relations
  belongs_to :course_type
  belongs_to :language
  belongs_to :unit

  # validations: presence
  validates_presence_of :code
  validates_presence_of :laboratory
  validates_presence_of :name
  validates_presence_of :practice
  validates_presence_of :program_type
  validates_presence_of :status
  validates_presence_of :theoric

  # validations: uniqueness
  validates_uniqueness_of :name
  validates_uniqueness_of :code

  # validations: length
  validates_length_of :name
  validates_length_of :code

  # enums
  has_enum :status, passive: 0, active: 1
  has_enum :program_type, associate: 0, undergraduate: 1, master: 2, doctoral: 3

  # callbacks
  has_validation_callback :capitalize_attributes, :before
  has_validation_callback :assign_credit, :before

  test 'callbacks must set value the credit for a course' do
    course = @course.dup
    course.update(code: 'DD101', theoric: 10, practice: 3)
    assert_equal course.credit, 11.5
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
