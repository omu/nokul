# frozen_string_literal: true

class CreateStandards < ActiveRecord::Migration[6.0]
  def change
    create_table :standards do |t|
      t.references :accreditation_institution, foreign_key: true, null: false
      t.string :version
      t.integer :status

      t.timestamps
    end

    add_length_constraint :standards, :version, less_than_or_equal_to: 50

    add_presence_constraint :standards, :version

    add_null_constraint :standards, :status

    add_numericality_constraint :standards, :status, greater_than_or_equal_to: 0

    add_unique_constraint :standards, [:version, :accreditation_institution_id]
  end
end
