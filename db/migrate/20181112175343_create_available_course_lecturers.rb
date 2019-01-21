# frozen_string_literal: true

class CreateAvailableCourseLecturers < ActiveRecord::Migration[5.2]
  def change
    create_table :available_course_lecturers do |t|
      t.boolean :coordinator, default: false
      t.references :group, foreign_key: { to_table: :available_course_groups }, null: false
      t.references :lecturer, foreign_key: { to_table: :employees }, null: false
      t.timestamps
    end

    add_null_constraint :available_course_lecturers, :coordinator
  end
end
