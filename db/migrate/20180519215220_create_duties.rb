# frozen_string_literal: true

class CreateDuties < ActiveRecord::Migration[5.2]
  def change
    create_table :duties do |t|
      t.boolean :temporary, default: true
      t.date :start_date
      t.date :end_date
      t.references :employee,
                   null: false,
                   foreign_key: true
      t.references :unit,
                   null: false,
                   foreign_key: true
      t.timestamps
    end

    add_null_constraint :duties, :temporary
    add_null_constraint :duties, :start_date
  end
end
