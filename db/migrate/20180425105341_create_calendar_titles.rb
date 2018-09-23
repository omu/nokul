# frozen_string_literal: true

class CreateCalendarTitles < ActiveRecord::Migration[5.2]
  def change
    create_table :calendar_titles do |t|
      t.string :name, null: false, limit: 255
      t.timestamps
    end
  end
end
