# frozen_string_literal: true

class CreateCurriculumSemesters < ActiveRecord::Migration[5.2]
  def change
    create_table :curriculum_semesters do |t|
      t.integer :sequence
      t.integer :year
      t.references :curriculum, foreign_key: true
      t.timestamps
    end

    add_null_constraint :curriculum_semesters, :sequence
    add_null_constraint :curriculum_semesters, :year

    add_numericality_constraint :curriculum_semesters, :year,
                                greater_than: 0
    add_numericality_constraint :curriculum_semesters, :sequence,
                                greater_than: 0
  end
end
