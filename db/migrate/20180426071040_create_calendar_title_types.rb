# frozen_string_literal: true

class CreateCalendarTitleTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :calendar_title_types do |t|
      t.references :type, foreign_key: { to_table: :calendar_types }
      t.references :title, foreign_key: { to_table: :calendar_titles }
      t.integer :status, default: 1
      t.timestamps
    end
  end
end
