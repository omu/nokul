# frozen_string_literal: true

class AddCreatedAtFieldsToAddressAndIdentity < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :created_at, :datetime, null: false
    add_column :identitites, :created_at, :datetime, null: false
  end
end
