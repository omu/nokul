# frozen_string_literal: true

class CreateCurriculumPrograms < ActiveRecord::Migration[5.2]
  def change
    create_table :curriculum_programs do |t|
      t.references :unit,
                   null: false,
                   foreign_key: true
      t.references :curriculum,
                   null: false,
                   foreign_key: true
    end
  end
end
