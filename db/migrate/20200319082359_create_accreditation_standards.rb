# frozen_string_literal: true

class CreateAccreditationStandards < ActiveRecord::Migration[6.0]
  def change
    create_table :accreditation_standards do |t|
      t.references :accreditation_institution, foreign_key: true, null: false
      t.string :version
      t.integer :status

      t.timestamps
    end

    add_length_constraint :accreditation_standards, :version, less_than_or_equal_to: 50

    add_presence_constraint :accreditation_standards, :version

    add_null_constraint :accreditation_standards, :status

    add_numericality_constraint :accreditation_standards, :status, greater_than_or_equal_to: 0

    add_unique_constraint :accreditation_standards, [:version, :accreditation_institution_id]
  end
end
