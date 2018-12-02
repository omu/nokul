# frozen_string_literal: true

class CreateCourseTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :course_types do |t|
      t.string :name, limit: 255
      t.string :code, limit: 50
      t.decimal :min_credit, precision: 5, scale: 2, default: 0, null: false
      t.timestamps
    end
  end
end
