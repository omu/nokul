# frozen_string_literal: true

class CreateGrades < ActiveRecord::Migration[6.0]
  def change
    create_table :grades do |t|
      t.references :course_assessment_method, foreign_key: true, null: false
      t.references :course_enrollment, foreign_key: true, null: false
      t.integer :point

      t.timestamps
    end

    add_numericality_constraint :grades, :point,
                                greater_than_or_equal_to: 0,
                                less_than_or_equal_to: 100                  
  end
end
