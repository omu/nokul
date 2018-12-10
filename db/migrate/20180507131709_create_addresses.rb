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
      t.datetime :updated_at
    end

    add_presence_constraint :addresses, :type
    add_presence_constraint :addresses, :full_address
    add_presence_constraint :addresses, :updated_at

    add_length_constraint :addresses, :phone_number, less_than_or_equal_to: 255
    add_length_constraint :addresses, :full_address, less_than_or_equal_to: 255

    add_numericality_constraint :addresses, :type,
                                            greater_than_or_equal_to: 0
  end
end
