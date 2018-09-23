# frozen_string_literal: true

class CreateDuties < ActiveRecord::Migration[5.2]
  def change
    create_table :duties do |t|
      t.boolean :temporary, null: false
      t.date :start_date, null: false
      t.date :end_date
      t.references :employee
      t.references :unit
      t.timestamps
    end
  end
end
