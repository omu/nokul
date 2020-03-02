# frozen_string_literal: true

class AddStatusToCourseAssessmentMethod < ActiveRecord::Migration[6.0]
  def change
    add_column :course_assessment_methods, :status, :integer, null: false, default: 0
  end
end
