class AddLanguageIdToCourses < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :language_id, :integer, foreign_key: true
    add_index :courses, :language_id
  end
end
