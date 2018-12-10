# frozen_string_literal: true

class CreateCurriculumCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :curriculum_courses do |t|
      t.integer :type
      t.references :course,
                   null: false,
                   foreign_key: true
      t.references :curriculum_semester,
                   null: false,
                   foreign_key: true
      t.references :curriculum_course_group,
                   foreign_key: true
      t.decimal :ects, precision: 5, scale: 2, default: 0
      t.timestamps
    end

    add_presence_constraint :curriculum_courses, :ects
    add_numericality_constraint :curriculum_courses, :type,
                                                     greater_than_or_equal_to: 0
  end
end
