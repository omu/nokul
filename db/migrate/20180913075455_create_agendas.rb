class CreateAgendas < ActiveRecord::Migration[5.2]
  def change
    create_table :agendas do |t|
      t.text :description, null: false
      t.references :unit, foreign_key: true
      t.references :agenda_type, foreign_key: true
      t.integer :status, null: false, default: 0
      t.timestamps
    end
  end
end
