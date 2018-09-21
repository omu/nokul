class RemoveTimestampsFromLanguages < ActiveRecord::Migration[5.2]
  def change
    remove_column :languages, :created_at, :datetime
    remove_column :languages, :updated_at, :datetime
  end
end
