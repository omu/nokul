# frozen_string_literal: true

class CreateLanguages < ActiveRecord::Migration[5.2]
  def change
    create_table :languages do |t|
      t.string :name, null: false, limit: 255
      t.string :iso, null: false, limit: 255
    end
  end
end
