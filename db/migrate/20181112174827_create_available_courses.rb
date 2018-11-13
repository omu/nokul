# frozen_string_literal: true

class CreateAvailableCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :available_courses do |t|
      t.references :academic_term
      t.references :course
      t.timestamps
    end
  end
end
