# frozen_string_literal: true

class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.integer :district_id, null: false
      t.string :neighbourhood
      t.text :full_address, null: false
      t.datetime :updated_at, null: false
      t.belongs_to :user, foreign_key: true
    end
  end
end
