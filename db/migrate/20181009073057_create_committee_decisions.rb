# frozen_string_literal: true

class CreateCommitteeDecisions < ActiveRecord::Migration[5.2]
  def change
    create_table :committee_decisions do |t|
      t.string :description
      t.string :decision_no
      t.integer :year
      t.references :meeting_agenda,
                   null: false,
                   foreign_key: true
      t.timestamps
    end

    add_presence_constraint :committee_decisions, :description
    add_presence_constraint :committee_decisions, :decision_no
    add_null_constraint :committee_decisions, :year

    add_length_constraint :committee_decisions, :decision_no, less_than_or_equal_to: 255
    add_length_constraint :committee_decisions, :description, less_than_or_equal_to: 65535

    add_numericality_constraint :committee_decisions, :year,
                                greater_than_or_equal_to: 1960,
                                less_than_or_equal_to: 2050
  end
end
