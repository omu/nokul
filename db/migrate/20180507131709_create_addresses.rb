# frozen_string_literal: true

class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.integer :type, null: false
      t.string :phone_number, limit: 255
      t.string :full_address, null: false, limit: 255
      t.references :district
      t.references :user
      t.timestamps
    end
  end
end
