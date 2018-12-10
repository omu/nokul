# frozen_string_literal: true

class CreateCurriculums < ActiveRecord::Migration[5.2]
  def change
    create_table :curriculums do |t|
      t.string :name
      t.integer :semesters_count, default: 0
      t.integer :status
      t.references :unit,
                   null: false,
                   foreign_key: true
    end

    add_presence_constraint :curriculums, :status
    add_presence_constraint :curriculums, :semesters_count

    add_length_constraint :curriculums, :name, less_than_or_equal_to: 255

    add_numericality_constraint :curriculums, :semesters_count,
                                              greater_than_or_equal_to: 0
    add_numericality_constraint :curriculums, :status,
                                              greater_than_or_equal_to: 0
  end
end
