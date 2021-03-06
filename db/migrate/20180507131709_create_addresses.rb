# frozen_string_literal: true

class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.integer :type
      t.string :phone_number
      t.string :full_address
      t.references :district,
                   null: false,
                   foreign_key: true
      t.references :user,
                   null: false,
                   foreign_key: true
      t.datetime :updated_at, default: -> { 'CURRENT_TIMESTAMP' }
      t.datetime :created_at, default: -> { 'CURRENT_TIMESTAMP' }
    end

    add_null_constraint :addresses, :type
    add_null_constraint :addresses, :updated_at
    add_null_constraint :addresses, :created_at
    add_presence_constraint :addresses, :full_address

    add_length_constraint :addresses, :phone_number, less_than_or_equal_to: 255
    add_length_constraint :addresses, :full_address, less_than_or_equal_to: 255

    add_numericality_constraint :addresses, :type,
                                greater_than_or_equal_to: 0
  end
end
