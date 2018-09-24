# frozen_string_literal: true

class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.boolean :active, default: true, null: false
      t.references :title
      t.references :user
      t.timestamps
    end
  end
end
