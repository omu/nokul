# frozen_string_literal: true

class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.boolean :active, default: true
      t.references :title,
                   null: false,
                   foreign_key: true
      t.references :user,
                   null: false,
                   foreign_key: true
      t.timestamps
    end

    add_null_constraint :employees, :active
  end
end
