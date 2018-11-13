# frozen_string_literal: true

class CreateAvailableCourseLecturers < ActiveRecord::Migration[5.2]
  def change
    create_table :available_course_lecturers do |t|
      t.boolean :coordinator, default: false, null: false
      t.references :available_course_group
      t.references :lecturer, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
