# frozen_string_literal: true

class CreateUnitStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :unit_statuses do |t|
      t.string :name, null: false, limit: 255
      t.integer :code, null: false
    end
  end
end
