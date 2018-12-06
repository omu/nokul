# frozen_string_literal: true

class GroupCourse < ApplicationRecord
  # relations
  belongs_to :course
  belongs_to :course_group

  # validations
  validates :course, uniqueness: { scope: :course_group_id }
end
