class CreateTerms < ActiveRecord::Migration[5.2]
  def change
    create_table :terms do |t|
      t.string :name, null: false, limit: 255
      t.string :identifier, null: false, limit: 50
    end
  end
end
