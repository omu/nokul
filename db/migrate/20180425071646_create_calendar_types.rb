class CreateCalendarTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :calendar_types do |t|
      t.string :name, unique: true, null: false
    end
  end
end
