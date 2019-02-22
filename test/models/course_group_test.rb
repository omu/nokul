# frozen_string_literal: true

require 'test_helper'

class CourseGroupTest < ActiveSupport::TestCase
  extend Support::Minitest::AssociationHelper
  extend Support::Minitest::CallbackHelper
  extend Support::Minitest::ValidationHelper

  # relations
  belongs_to :course_group_type
  belongs_to :unit
  has_many :group_courses, dependent: :destroy
  has_many :courses, through: :group_courses
  has_many :curriculum_course_groups, dependent: :destroy

  # validations: presence
  validates_presence_of :course_ids
  validates_presence_of :name
  validates_presence_of :total_ects_condition

  # validations: length
  validates_length_of :name

  # validations: uniqueness
  validates_uniqueness_of :name

  # callbacks
  before_validation :capitalize_attributes
end
