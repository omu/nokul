# frozen_string_literal: true

class AddMobilePhoneToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :mobile_phone, :string
    remove_column :addresses, :phone_number, :string

    add_length_constraint :users, :mobile_phone, less_than_or_equal_to: 255
  end
end
