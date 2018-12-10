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

    add_presence_constraint :curriculum_course_groups, :ects
  end
end
