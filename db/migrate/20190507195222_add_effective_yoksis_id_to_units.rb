# frozen_string_literal: true

class AddEffectiveYoksisIdToUnits < ActiveRecord::Migration[6.0]
  def change
  	add_column :units, :effective_yoksis_id, :string, comment: 'Bir birimin birlikte yonetildigi ust birimi ifade eder'
  end
end
