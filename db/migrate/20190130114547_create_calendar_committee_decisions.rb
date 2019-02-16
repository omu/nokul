# frozen_string_literal: true

class CreateCalendarCommitteeDecisions < ActiveRecord::Migration[6.0]
  def change
    create_table :calendar_committee_decisions do |t|
      t.references :calendar, foreign_key: true, null: false
      t.references :committee_decision, foreign_key: true, null: false
      t.timestamps
    end
  end
end
