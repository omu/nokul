# frozen_string_literal: true

require 'test_helper'

class CourseGroupTest < ActiveSupport::TestCase
  include AssociationTestModule
  include CallbackTestModule
  include ValidationTestModule

  setup do
    @course_group = course_groups(:bilgisayar_muhendligi_teknik_secmeli_1)
  end

  # relations
  belongs_to :course_group_type
  belongs_to :unit
  has_many :group_courses
  has_many :courses
  has_many :curriculum_course_groups

  # validations: presence
  validates_presence_of :course_ids
  validates_presence_of :name
  validates_presence_of :total_ects_condition

  # validations: length
  validates_length_of :name

  # validations: uniqueness
  validates_uniqueness_of :name

  # callbacks
  has_validation_callback :capitalize_attributes, :before
end
