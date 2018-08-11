class AddProfileFieldsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :profile_preferences, :jsonb
  end
end
