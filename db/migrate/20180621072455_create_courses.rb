# frozen_string_literal: true

class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :name
      t.string :code
      t.integer :theoric, default: 0
      t.integer :practice, default: 0
      t.integer :laboratory, default: 0
      t.decimal :credit, precision: 5, scale: 2, default: 0
      t.integer :program_type
      t.integer :status
      t.references :unit,
                   null: false,
                   foreign_key: true
      t.references :language,
                   null: false,
                   foreign_key: true
      t.references :course_type,
                   foreign_key: true,
                   null: false
      t.timestamps
    end

    add_presence_constraint :courses, :name
    add_presence_constraint :courses, :code
    add_presence_constraint :courses, :theoric
    add_presence_constraint :courses, :practice
    add_presence_constraint :courses, :laboratory
    add_presence_constraint :courses, :credit
    add_presence_constraint :courses, :program_type
    add_presence_constraint :courses, :status

    add_length_constraint :courses, :name, less_than_or_equal_to: 255
    add_length_constraint :courses, :code, less_than_or_equal_to: 255

    add_numericality_constraint :courses, :theoric,
                                            greater_than_or_equal_to: 0
    add_numericality_constraint :courses, :practice,
                                            greater_than_or_equal_to: 0
    add_numericality_constraint :courses, :laboratory,
                                            greater_than_or_equal_to: 0
    add_numericality_constraint :courses, :program_type,
                                            greater_than_or_equal_to: 0
    add_numericality_constraint :courses, :status,
                                            greater_than_or_equal_to: 0
  end
end
