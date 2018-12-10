# frozen_string_literal: true

class CreateCommitteeMeetings < ActiveRecord::Migration[5.2]
  def change
    create_table :committee_meetings do |t|
      t.integer :meeting_no
      t.date :meeting_date
      t.integer :year
      t.references :unit,
                   null: false,
                   foreign_key: true
      t.timestamps
    end

    add_presence_constraint :committee_meetings, :meeting_no
    add_presence_constraint :committee_meetings, :meeting_date
    add_presence_constraint :committee_meetings, :year

    add_numericality_constraint :committee_meetings, :meeting_no,
                                                     greater_than_or_equal_to: 0
    add_numericality_constraint :committee_meetings, :year,
                                                     greater_than_or_equal_to: 1950,
                                                     less_than_or_equal_to: 2050
  end
end
