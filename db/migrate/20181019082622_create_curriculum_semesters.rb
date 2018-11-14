# frozen_string_literal: true

class CreateCurriculumSemesters < ActiveRecord::Migration[5.2]
  def change
    create_table :curriculum_semesters do |t|
      t.string :name, null: false, limit: 255
      t.integer :sequence
      t.references :curriculum, foreign_key: true
      t.timestamps
    end
  end
end
