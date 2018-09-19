# frozen_string_literal: true

class GroupCourse < ApplicationRecord
  # relations
  belongs_to :course
  belongs_to :course_unit_group
end
