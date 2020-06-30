# frozen_string_literal: true

class AddIdentifierToEvaluationType < ActiveRecord::Migration[6.0]
  def change
    add_column :evaluation_types, :identifier, :string
    add_length_constraint :evaluation_types, :identifier, less_than_or_equal_to: 255
    add_unique_constraint :evaluation_types, :identifier
  end
end
