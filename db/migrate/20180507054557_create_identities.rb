# frozen_string_literal: true

class CreateIdentities < ActiveRecord::Migration[5.1]
  def change
    create_table :identities do |t|
      t.integer :name, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :mothers_name
      t.string :fathers_name
      t.integer :gender, null: false
      t.integer :marital_status
      t.string :place_of_birth, null: false
      t.date :date_of_birth, null: false
      t.string :registered_to
      t.datetime :updated_at, null: false
      t.belongs_to :user, foreign_key: true
      t.belongs_to :student, foreign_key: true
    end
  end
end
