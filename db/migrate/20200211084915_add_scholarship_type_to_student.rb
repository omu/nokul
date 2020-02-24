# frozen_string_literal: true

class AddScholarshipTypeToStudent < ActiveRecord::Migration[6.0]
  def change
    add_reference :students, :scholarship_type, foreign_key: true
  end
end
