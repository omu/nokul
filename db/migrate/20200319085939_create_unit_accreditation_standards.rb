# frozen_string_literal: true

class CreateUnitAccreditationStandards < ActiveRecord::Migration[6.0]
  def change
    create_table :unit_accreditation_standards do |t|
      t.references :unit, foreign_key: true
      t.references :accreditation_standard, foreign_key: true

      t.timestamps
    end
  end
end
