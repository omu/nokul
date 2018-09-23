# frozen_string_literal: true

class CreatePositions < ActiveRecord::Migration[5.2]
  def change
    create_table :positions do |t|
      t.date :start_date, null: false
      t.date :end_date
      t.references :duty
      t.references :administrative_function
      t.timestamps
    end
  end
end
