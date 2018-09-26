# frozen_string_literal: true

class CreateIdentities < ActiveRecord::Migration[5.1]
  def change
    create_table :identities do |t|
      t.integer :type, null: false
      t.string :first_name, null: false, limit: 255
      t.string :last_name, null: false, limit: 255
      t.string :mothers_name, limit: 255
      t.string :fathers_name, limit: 255
      t.integer :gender, null: false
      t.integer :marital_status
      t.string :place_of_birth, null: false, limit: 255
      t.date :date_of_birth, null: false
      t.string :registered_to, limit: 255
      t.datetime :updated_at, null: false
      t.references :user
      t.references :student
    end
  end
end
