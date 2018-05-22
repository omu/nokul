class CreateTitles < ActiveRecord::Migration[5.2]
  def change
    create_table :titles do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.string :branch, null: false
    end
  end
end
