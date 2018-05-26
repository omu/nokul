# frozen_string_literal: true

class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.boolean :active, default: true, null: false
      t.references :title, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
