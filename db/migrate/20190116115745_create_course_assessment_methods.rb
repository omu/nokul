# frozen_string_literal: true

class CreateCourseAssessmentMethods < ActiveRecord::Migration[5.2]
  def change
    create_table :course_assessment_methods do |t|
      t.references :course_evaluation_type, foreign_key: true, null: false
      t.references :assessment_method, foreign_key: true, null: false
      t.integer :percentage
      t.timestamps
    end

    add_null_constraint :course_assessment_methods, :percentage

    add_numericality_constraint :course_assessment_methods, :percentage,
                                greater_than_or_equal_to: 0,
                                less_than_or_equal_to: 100
  end
end
