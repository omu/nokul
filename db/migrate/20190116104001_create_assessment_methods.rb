# frozen_string_literal: true

class CreateAssessmentMethods < ActiveRecord::Migration[5.2]
  def change
    create_table :assessment_methods do |t|
      t.string :name
    end

    add_presence_constraint :assessment_methods, :name
    add_length_constraint :assessment_methods, :name, less_than_or_equal_to: 255
    add_unique_constraint :assessment_methods, :name
  end
end
