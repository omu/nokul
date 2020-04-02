# frozen_string_literal: true

class CreateTuitionDebts < ActiveRecord::Migration[6.0]
  def change
    create_table :tuition_debts do |t|
      t.references :student, null: false, foreign_key: true
      t.references :academic_term, null: false, foreign_key: true
      t.references :unit_tuition, foreign_key: true
      t.decimal :amount, precision: 8, scale: 3
      t.text :description
      t.integer :type
      t.boolean :paid, default: false

      t.timestamps
    end

    add_null_constraint :tuition_debts, :amount
    add_null_constraint :tuition_debts, :type
    add_null_constraint :tuition_debts, :paid
    add_numericality_constraint :tuition_debts, :amount, greater_than: 0
    add_numericality_constraint :tuition_debts, :type, greater_than_or_equal_to: 0
    add_length_constraint :tuition_debts, :description, less_than_or_equal_to: 65_535
  end
end
