# frozen_string_literal: true

class CreateAvailableCourseLecturers < ActiveRecord::Migration[5.2]
  def change
    create_table :available_course_lecturers do |t|
      t.boolean :coordinator, default: false, null: false
      t.references :group, foreign_key: { to_table: :available_course_groups }
      t.references :lecturer, foreign_key: { to_table: :employees }
      t.timestamps
    end
  end
end
