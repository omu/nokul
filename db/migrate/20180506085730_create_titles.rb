# frozen_string_literal: true

class CreateTitles < ActiveRecord::Migration[5.2]
  def change
    create_table :titles do |t|
      t.string :name, null: false, limit: 255
      t.string :code, null: false, limit: 255
      t.string :branch, null: false, limit: 255
    end
  end
end
