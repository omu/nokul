# frozen_string_literal: true

class CreateCalendarTitleTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :calendar_title_types do |t|
      t.references :type,
                   null: false,
                   foreign_key: { to_table: :calendar_types }
      t.references :title,
                   null: false,
                   foreign_key: { to_table: :calendar_titles }
      t.boolean :active, default: true
      t.timestamps
    end

    add_null_constraint :calendar_title_types, :active
  end
end
