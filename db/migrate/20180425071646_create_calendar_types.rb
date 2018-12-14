# frozen_string_literal: true

class CreateCalendarTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :calendar_types do |t|
      t.string :name
      t.timestamps
    end

    add_presence_constraint :calendar_types, :name
    add_length_constraint :calendar_types, :name, less_than_or_equal_to: 255
    add_unique_constraint :calendar_types, :name
  end
end
