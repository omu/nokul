# frozen_string_literal: true

class CreateTitles < ActiveRecord::Migration[5.2]
  def change
    create_table :titles do |t|
      t.string :name
      t.string :code
      t.string :branch
    end

    add_presence_constraint :titles, :name
    add_presence_constraint :titles, :code
    add_presence_constraint :titles, :branch

    add_length_constraint :titles, :name, less_than_or_equal_to: 255
    add_length_constraint :titles, :code, less_than_or_equal_to: 255
    add_length_constraint :titles, :branch, less_than_or_equal_to: 255
  end
end
