# frozen_string_literal: true

class CreateUniversityTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :university_types do |t|
      t.string :name, null: false, limit: 255
      t.integer :code, null: false
    end
  end
end
