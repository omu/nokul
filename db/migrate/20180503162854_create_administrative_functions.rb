# frozen_string_literal: true

class CreateAdministrativeFunctions < ActiveRecord::Migration[5.2]
  def change
    create_table :administrative_functions do |t|
      t.string :name, null: false, limit: 255
      t.integer :code, null: false
    end
  end
end
