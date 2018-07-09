class AddSlugToEmployee < ActiveRecord::Migration[5.2]
  def change
    add_column :employees, :slug, :string, unique: true
  end
end
