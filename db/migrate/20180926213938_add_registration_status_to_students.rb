# frozen_string_literal: true

class AddRegistrationStatusToStudents < ActiveRecord::Migration[5.2]
  def change
    add_column :students, :permanently_registered, :boolean, null: false, default: false
  end
end
