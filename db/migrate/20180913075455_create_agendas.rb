# frozen_string_literal: true

class CreateAgendas < ActiveRecord::Migration[5.2]
  def change
    create_table :agendas do |t|
      t.string :description
      t.integer :status, default: 0
      t.references :unit,
                   null: false,
                   foreign_key: true
      t.references :agenda_type,
                   null: false,
                   foreign_key: true
      t.timestamps
    end

    add_presence_constraint :agendas, :description
    add_presence_constraint :agendas, :status

    add_length_constraint :agendas, :description, less_than_or_equal_to: 65535

    add_numericality_constraint :agendas, :status,
                                          greater_than_or_equal_to: 0
  end
end
