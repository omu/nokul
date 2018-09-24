# frozen_string_literal: true

class CreateCountries < ActiveRecord::Migration[5.1]
  def change
    create_table :countries do |t|
      t.string :name, null: false, limit: 255
      t.string :alpha_2_code, null: false, limit: 255
      t.string :alpha_3_code, null: false, limit: 255
      t.string :numeric_code, null: false, limit: 255
      t.string :mernis_code, limit: 255
      t.integer :yoksis_code
    end
  end
end
