# frozen_string_literal: true

class AddActivatedToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :activated, :boolean, default: false
    add_column :users, :activated_at, :datetime

    add_null_constraint :users, :activated
  end
end
