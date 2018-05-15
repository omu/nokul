class CreateCalendarTitleTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :calendar_title_types do |t|
      t.references :type, foreign_key: { to_table: :calendar_types }
      t.references :title, foreign_key: { to_table: :calendar_titles }
      t.integer :status, default: 0
      t.timestamps
    end
    add_index :calendar_title_types, [:type_id, :title_id], unique: true, name: 'index_of_calendar_title_types'
  end
end
