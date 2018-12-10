# frozen_string_literal: true

class CreateMeetingAgendas < ActiveRecord::Migration[5.2]
  def change
    create_table :meeting_agendas do |t|
      t.references :agenda,
                   null: false,
                   foreign_key: true
      t.references :committee_meeting,
                   null: false,
                   foreign_key: true
      t.integer :sequence_no
      t.timestamps
    end

    add_presence_constraint :meeting_agendas, :sequence_no
    add_numericality_constraint :meeting_agendas, :sequence_no,
                                                  greater_than_or_equal_to: 0
  end
end
