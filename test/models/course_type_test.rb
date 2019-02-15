# frozen_string_literal: true

require 'test_helper'

class CourseTypeTest < ActiveSupport::TestCase
  include AssociationTestModule
  include ValidationTestModule

  setup do
    @course_type = course_types(:internship)
  end

  # relations
  has_many :courses

  # validations: presence
  validates_presence_of :name
  validates_presence_of :code
  validates_presence_of :min_credit

  # validations: uniqueness
  validates_uniqueness_of :name
  validates_uniqueness_of :code

  # validations: length
  validates_length_of :name
  validates_length_of :code

  # validations: numericality
  test 'presence numericality for min_credit of a course type' do
    @course_type.min_credit = -1
    assert_not @course_type.valid?
    assert_not_empty @course_type.errors[:min_credit]
  end
end
