# frozen_string_literal: true

class CreateDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :documents do |t|
      t.string :name
      t.string :statement
    end

    add_presence_constraint :documents, :name
    add_length_constraint :documents, :name, less_than_or_equal_to: 255
    add_length_constraint :documents, :statement, less_than_or_equal_to: 255
  end
end
