# frozen_string_literal: true

class CreateUnitStandards < ActiveRecord::Migration[6.0]
  def change
    create_table :unit_standards do |t|
      t.references :unit, foreign_key: true
      t.references :standard, foreign_key: true

      t.timestamps
    end
  end
end
