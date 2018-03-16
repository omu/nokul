class AddIdNumberToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :id_number, :integer, null: false, unique: true
  end
end
