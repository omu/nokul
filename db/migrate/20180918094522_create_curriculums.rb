# frozen_string_literal: true

class CreateCurriculums < ActiveRecord::Migration[5.2]
  def change
    create_table :curriculums do |t|
      t.string :name, limit: 255
      t.integer :number_of_semesters
      t.integer :status, null: false
      t.references :unit
    end
  end
end
