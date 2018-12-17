# frozen_string_literal: true

class CreateAgendaTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :agenda_types do |t|
      t.string :name
      t.timestamps
    end

    add_presence_constraint :agenda_types, :name
    add_length_constraint :agenda_types, :name, less_than_or_equal_to: 255
  end
end
