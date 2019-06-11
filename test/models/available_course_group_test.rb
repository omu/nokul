# frozen_string_literal: true

require 'test_helper'

class AvailableCourseGroupTest < ActiveSupport::TestCase
  extend Support::Minitest::AssociationHelper
  extend Support::Minitest::ValidationHelper

  # relations
  belongs_to :available_course, counter_cache: :groups_count
  has_many :lecturers, class_name:  'AvailableCourseLecturer',
                       foreign_key: :group_id,
                       inverse_of:  :group,
                       dependent:   :destroy

  # validations: presence
  validates_presence_of :name

  # validations: uniqueness
  validates_uniqueness_of :name

  # validations: length
  validates_length_of :name

  # validations: nested models
  validates_presence_of_nested_model :lecturers
end
