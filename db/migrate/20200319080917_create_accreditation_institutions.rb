# frozen_string_literal: true

class CreateAccreditationInstitutions < ActiveRecord::Migration[6.0]
  def change
    create_table :accreditation_institutions do |t|
      t.string :name

      t.timestamps
    end

    add_length_constraint :accreditation_institutions, :name, less_than_or_equal_to: 255

    add_presence_constraint :accreditation_institutions, :name

    add_unique_constraint :accreditation_institutions, :name
  end
end
