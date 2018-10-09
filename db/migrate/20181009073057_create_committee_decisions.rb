# frozen_string_literal: true

class CreateCommitteeDecisions < ActiveRecord::Migration[5.2]
  def change
    create_table :committee_decisions do |t|
      t.text :description, null: false, limit: 65535
      t.string :decision_no, null: false
      t.references :meeting_agenda
      t.timestamps
    end
  end
end
