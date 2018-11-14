# frozen_string_literal: true

class AddMissingLimitToComitteeDecisions < ActiveRecord::Migration[5.2]
  def change
    change_column :committee_decisions, :decision_no, :string, limit: 255
  end
end
