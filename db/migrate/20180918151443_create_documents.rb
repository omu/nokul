# frozen_string_literal: true

class CreateDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :documents do |t|
      t.string :name, null: false, limit: 255
      t.string :statement, limit: 255
      t.timestamps
    end
  end
end
