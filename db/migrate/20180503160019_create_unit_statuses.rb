# frozen_string_literal: true

class CreateUnitStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :unit_statuses do |t|
      t.string :name
      t.integer :code
    end

    add_presence_constraint :unit_statuses, :name
    add_null_constraint :unit_statuses, :code

    add_length_constraint :unit_statuses, :name,
                                          less_than_or_equal_to: 255
    add_numericality_constraint :unit_statuses, :code,
                                greater_than_or_equal_to: 0

    add_unique_constraint :unit_statuses, :name
    add_unique_constraint :unit_statuses, :code
  end
end
