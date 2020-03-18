# frozen_string_literal: true

class AddStageToStudent < ActiveRecord::Migration[6.0]
  def change
    add_reference :students, :stage, foreign_key: { to_table: :student_grades }
  end
end
