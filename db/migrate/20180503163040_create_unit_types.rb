# frozen_string_literal: true

class CreateUnitTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :unit_types do |t|
      t.string :name, null: false, limit: 255
      t.integer :code, null: false
    end
  end
end
