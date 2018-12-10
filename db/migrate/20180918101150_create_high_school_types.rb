# frozen_string_literal: true

class CreateHighSchoolTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :high_school_types do |t|
      t.string :name
      t.integer :code
    end

    add_presence_constraint :high_school_types, :name
    add_presence_constraint :high_school_types, :code

    add_length_constraint :high_school_types, :name, less_than_or_equal_to: 255

    add_numericality_constraint :high_school_types, :code,
                                                    greater_than_or_equal_to: 0
  end
end
