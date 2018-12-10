# frozen_string_literal: true

class CreateAvailableCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :available_courses do |t|
      t.references :academic_term,
                   null: false,
                   foreign_key: true
      t.references :curriculum,
                   null: false,
                   foreign_key: true
      t.references :course,
                   null: false,
                   foreign_key: true
      t.timestamps
    end
  end
end
