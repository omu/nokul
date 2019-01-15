# frozen_string_literal: true

class CreateDocumentTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :document_types do |t|
      t.string :name
      t.boolean :active, default: true
    end

    add_presence_constraint :document_types, :name
    add_null_constraint :document_types, :active
    add_length_constraint :document_types, :name, less_than_or_equal_to: 255
  end
end
