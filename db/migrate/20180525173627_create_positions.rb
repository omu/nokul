# frozen_string_literal: true

class CreatePositions < ActiveRecord::Migration[5.2]
  def change
    create_table :positions do |t|
      t.date :start_date
      t.date :end_date
      t.references :duty,
                   null: false,
                   foreign_key: true
      t.references :administrative_function,
                   null: false,
                   foreign_key: true
      t.timestamps
    end

    add_presence_constraint :positions, :start_date
  end
end
