# frozen_string_literal: true

class AddIdentifierToCalendarTitle < ActiveRecord::Migration[5.2]
  def change
    add_column :calendar_titles, :identifier, :string, null: false, limit: 255
  end
end
