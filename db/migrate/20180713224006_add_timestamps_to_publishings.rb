class AddTimestampsToPublishings < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :created_at, :datetime
    add_column :projects, :created_at, :datetime
    add_column :certifications, :created_at, :datetime
  end
end
