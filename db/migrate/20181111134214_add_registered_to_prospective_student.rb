# frozen_string_literal: true

class AddRegisteredToProspectiveStudent < ActiveRecord::Migration[5.2]
  def change
    add_column :prospective_students, :registered, :boolean, default: false
  end
end
