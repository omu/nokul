class CreateDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :documents do |t|
      t.string :name, unique: true, null: false
      t.string :statement

      t.timestamps
    end
  end
end
