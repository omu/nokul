# frozen_string_literal: true

class AddLockableModuleToDevise < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :failed_attempts, :integer, default: 0, null: false
    add_column :users, :unlock_token, :string, limit: 255
    add_column :users, :locked_at, :datetime
  end
end
