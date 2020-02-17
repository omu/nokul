# frozen_string_literal: true

class CreateUnitTuition < ActiveRecord::Migration[6.0]
  def change
    create_table :unit_tuitions do |t|
      t.references :unit, foreign_key: true
      t.references :tuition, foreign_key: true
    end
  end
end
