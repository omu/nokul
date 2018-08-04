class AddSlugToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :slug, :string, unique: true
  end
end
