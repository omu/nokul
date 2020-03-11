# frozen_string_literal: true

class CreateUnitStandards < ActiveRecord::Migration[6.0]
  def change
    create_table :unit_standards do |t|
      t.references :standard, foreign_key: true, null: false
      t.references :unit, foreign_key: true, null: false
      t.integer :status

      t.timestamps
    end

    add_null_constraint :unit_standards, :status

    add_numericality_constraint :unit_standards, :status, greater_than_or_equal_to: 0
  end
end
