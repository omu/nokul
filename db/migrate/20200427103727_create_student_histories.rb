# frozen_string_literal: true

class CreateStudentHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :student_histories do |t|
      t.references :student, null: false, foreign_key: true
      t.references :entrance_type, foreign_key: { to_table: :student_entrance_types }
      t.datetime :registration_date
      t.references :registration_term, foreign_key: { to_table: :academic_terms }
      t.datetime :graduation_date
      t.references :graduation_term, foreign_key: { to_table: :academic_terms }
      t.boolean :other_studentship, default: false
      t.integer :preparatory_class, default: 0
      t.timestamps
    end

    add_null_constraint :student_histories, :other_studentship
    add_numericality_constraint :student_histories, :preparatory_class,
                                greater_than_or_equal_to: 0
  end
end
