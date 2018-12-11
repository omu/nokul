# frozen_string_literal: true

class CreateCourseTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :course_types do |t|
      t.string :name
      t.string :code
      t.decimal :min_credit, precision: 5, scale: 2, default: 0
      t.timestamps
    end

    add_presence_constraint :course_types, :name
    add_presence_constraint :course_types, :code
    add_null_constraint :course_types, :min_credit

    add_length_constraint :course_types, :name, less_than_or_equal_to: 255
    add_length_constraint :course_types, :code, less_than_or_equal_to: 255

    add_numericality_constraint :course_types, :min_credit,
                                               greater_than_or_equal_to: 0
  end
end
