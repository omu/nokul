class AddProjectsCountToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :projects_count, :integer
  end
end
