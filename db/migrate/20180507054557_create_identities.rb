# frozen_string_literal: true

class CreateIdentities < ActiveRecord::Migration[5.1]
  def change
    create_table :identities do |t|
      t.integer :type
      t.string :first_name
      t.string :last_name
      t.string :mothers_name
      t.string :fathers_name
      t.integer :gender
      t.integer :marital_status
      t.string :place_of_birth
      t.date :date_of_birth
      t.string :registered_to
      t.datetime :updated_at
      t.references :user,
                   foreign_key: true
                   null: false
      t.references :student,
                   foreign_key: true
    end

    add_presence_constraint :identities, :type
    add_presence_constraint :identities, :first_name
    add_presence_constraint :identities, :last_name
    add_presence_constraint :identities, :gender
    add_presence_constraint :identities, :place_of_birth
    add_presence_constraint :identities, :date_of_birth
    add_presence_constraint :identities, :updated_at

    add_length_constraint :identities, :first_name, less_than_or_equal_to: 255
    add_length_constraint :identities, :last_name, less_than_or_equal_to: 255
    add_length_constraint :identities, :mothers_name, less_than_or_equal_to: 255
    add_length_constraint :identities, :fathers_name, less_than_or_equal_to: 255
    add_length_constraint :identities, :place_of_birth, less_than_or_equal_to: 255
    add_length_constraint :identities, :registered_to, less_than_or_equal_to: 255

    add_numericality_constraint :identities, :type,
                                             greater_than_or_equal_to: 0
    add_numericality_constraint :identities, :gender,
                                             greater_than_or_equal_to: 0
    add_numericality_constraint :identities, :marital_status,
                                             greater_than_or_equal_to: 0
  end
end
