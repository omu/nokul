# frozen_string_literal: true

class CreateAccreditationStandards < ActiveRecord::Migration[6.0]
  def change
    create_table :accreditation_standards do |t|
      t.string :name

      t.timestamps
    end

    add_length_constraint :accreditation_standards, :name, less_than_or_equal_to: 255

    add_presence_constraint :accreditation_standards, :name

    add_unique_constraint :accreditation_standards, :name
  end
end
