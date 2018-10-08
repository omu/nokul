# frozen_string_literal: true

class CreateMeetingAgendas < ActiveRecord::Migration[5.2]
  def change
    create_table :meeting_agendas do |t|
      t.references :agenda
      t.references :committee_meeting
      t.integer :sequence_no, null: false
      t.timestamps
    end
  end
end
