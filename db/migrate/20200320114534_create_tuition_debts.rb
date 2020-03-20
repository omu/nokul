# frozen_string_literal: true

class CreateTuitionDebts < ActiveRecord::Migration[6.0]
  def change
    create_table :tuition_debts do |t|
      t.references :student, null: false, foreign_key: true
      t.references :academic_term, null: false, foreign_key: true
      t.references :unit_tuition, null: false, foreign_key: true
      t.decimal :amount, precision: 8, scale: 3
      t.text :description

      t.timestamps
    end

    add_null_constraint :tuition_debts, :amount
    add_numericality_constraint :tuition_debts, :amount, greater_than: 0
    add_length_constraint :tuition_debts, :description, less_than_or_equal_to: 65_535
  end
end
