# frozen_string_literal: true

class CreateStandards < ActiveRecord::Migration[6.0]
  def change
    create_table :standards do |t|
      t.references :accreditation_standard, foreign_key: true, null: false
      t.integer :status

      t.timestamps
    end

    add_null_constraint :standards, :status

    add_numericality_constraint :standards, :status, greater_than_or_equal_to: 0
  end
end
