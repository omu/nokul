# frozen_string_literal: true

class CreateAgendas < ActiveRecord::Migration[5.2]
  def change
    create_table :agendas do |t|
      t.text :description, null: false, limit: 65535
      t.integer :status, null: false, default: 0
      t.references :unit
      t.references :agenda_type
      t.timestamps
    end
  end
end
