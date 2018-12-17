# frozen_string_literal: true

class CreateTerms < ActiveRecord::Migration[5.2]
  def change
    create_table :terms do |t|
      t.string :name
      t.string :identifier
    end

    add_presence_constraint :terms, :name
    add_presence_constraint :terms, :identifier

    add_length_constraint :terms, :name, less_than_or_equal_to: 255
    add_length_constraint :terms, :identifier, less_than_or_equal_to: 255

    add_unique_constraint :terms, :name
    add_unique_constraint :terms, :identifier
  end
end
