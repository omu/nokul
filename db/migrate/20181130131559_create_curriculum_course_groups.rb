# frozen_string_literal: true

class CreateCurriculumCourseGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :curriculum_course_groups do |t|
      t.references :course_group,
                   foreign_key: true,
                   null: false
      t.references :curriculum_semester,
                   foreign_key: true,
                   null: false
      t.decimal :ects, precision: 5, scale: 2, default: 0
      t.timestamps
    end

    add_null_constraint :curriculum_course_groups, :ects
    add_numericality_constraint :curriculum_course_groups, :ects,
                                greater_than_or_equal_to: 0
  end
end
