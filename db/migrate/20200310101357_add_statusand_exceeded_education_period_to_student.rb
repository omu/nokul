# frozen_string_literal: true

class AddStatusandExceededEducationPeriodToStudent < ActiveRecord::Migration[6.0]
  def change
    add_column :students, :status, :integer, default: 1
    add_column :students, :exceeded_education_period, :boolean, default: false
    
    add_null_constraint :students, :status 
    add_numericality_constraint :students, :status, greater_than_or_equal_to: 0

    remove_null_constraint :students, :permanently_registered
    remove_column :students, :permanently_registered, :boolean, default: false
  end
end
