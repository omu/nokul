class AddArticlesCountToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :articles_count, :integer
  end
end
