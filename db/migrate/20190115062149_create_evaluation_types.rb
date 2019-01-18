# frozen_string_literal: true

class CreateEvaluationTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :evaluation_types do |t|
      t.string :name
    end

    add_presence_constraint :evaluation_types, :name
    add_length_constraint :evaluation_types, :name, less_than_or_equal_to: 255
    add_unique_constraint :evaluation_types, :name
  end
end
