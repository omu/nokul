# frozen_string_literal: true

class AddMissingLimitToComitteeDecisions < ActiveRecord::Migration[5.2]
  def change
    reversible do |dir|
      dir.up   { change_column :committee_decisions, :decision_no, :string, limit: 255 }
      dir.down { change_column :committee_decisions, :decision_no, :string }
    end
  end
end
