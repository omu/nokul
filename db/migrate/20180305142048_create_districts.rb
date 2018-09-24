# frozen_string_literal: true

class CreateDistricts < ActiveRecord::Migration[5.2]
  def change
    create_table :districts do |t|
      t.string :name, null: false, limit: 255
      t.string :mernis_code, limit: 255
      t.boolean :active, default: true, null: false
      t.references :city
    end
  end
end
