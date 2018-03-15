class AddTypeFieldToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :type, :string, null: false
  end
end
