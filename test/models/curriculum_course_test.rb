# frozen_string_literal: true

require 'test_helper'

class CurriculumCourseTest < ActiveSupport::TestCase
  extend Support::Minitest::AssociationHelper
  extend Support::Minitest::CallbackHelper
  extend Support::Minitest::EnumerationHelper
  extend Support::Minitest::ValidationHelper

  # relations
  belongs_to :course
  belongs_to :curriculum_course_group, optional: true
  belongs_to :curriculum_semester
  has_many :available_courses, dependent: :destroy

  # validations: presence
  validates_presence_of :course
  validates_presence_of :curriculum_semester
  validates_presence_of :ects

  # validations: numericality
  validates_numericality_of :ects
  validates_numerical_range :ects, greater_than: 0

  # validations: uniqueness
  validates_uniqueness_of :course

  # enums
  enum type: { compulsory: 0, elective: 1 }

  # callbacks
  before_validation :assign_type

  test 'callbacks must set value the type for a curriculum course' do
    curriculum_course = curriculum_courses(:one).dup
    curriculum_course.course = courses(:test)
    curriculum_course.save
    assert_equal 'compulsory', curriculum_course.type
  end

  %i[
    code
    credit
    course_type
    name
    theoric
    practice
    laboratory
    program_type
  ].each do |method|
    test "can respond to #{method} method" do
      assert_respond_to curriculum_courses(:one), :code
      assert_equal curriculum_courses(:one).try(method),
                   curriculum_courses(:one).course.try(method)
    end
  end
end
