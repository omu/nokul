class CreateUnitStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :unit_statuses do |t|
      t.string :name, unique: true, null: false
      t.integer :code, unique: true, null: false
    end
  end
end
