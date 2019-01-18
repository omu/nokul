# frozen_string_literal: true

class CreateCourseEvaluationTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :course_evaluation_types do |t|
      t.references :available_course, foreign_key: true, null: false
      t.references :evaluation_type, foreign_key: true, null: false
      t.integer :percentage
      t.timestamps
    end

    add_null_constraint :course_evaluation_types, :percentage

    add_numericality_constraint :course_evaluation_types, :percentage,
                                greater_than_or_equal_to: 0,
                                less_than_or_equal_to: 100
  end
end
