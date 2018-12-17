# frozen_string_literal: true

class CreateLanguages < ActiveRecord::Migration[5.2]
  def change
    create_table :languages do |t|
      t.string :name
      t.string :iso
    end

    add_presence_constraint :languages, :name
    add_presence_constraint :languages, :iso

    add_length_constraint :languages, :name, less_than_or_equal_to: 255
    add_length_constraint :languages, :iso, less_than_or_equal_to: 255

    add_unique_constraint :languages, :name
    add_unique_constraint :languages, :iso
  end
end
