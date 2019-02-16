# frozen_string_literal: true

require 'test_helper'

class GroupCourseTest < ActiveSupport::TestCase
  include AssociationTestModule
  include ValidationTestModule

  # relations
  belongs_to :course
  belongs_to :course_group

  # validations: uniqueness
  validates_uniqueness_of :course
end
