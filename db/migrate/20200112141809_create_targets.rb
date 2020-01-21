# frozen_string_literal: true

class CreateTargets < ActiveRecord::Migration[6.0]
  def change
    create_table :targets do |t|
      t.integer :course_id
      t.integer :icc_id

      t.timestamps
    end

    add_length_constraint :targets, :course_id, greater_than_or_equal_to: 0
    add_length_constraint :targets, :icc_id, greater_than_or_equal_to: 0

    add_unique_constraint :targets, [:course_id, :icc_id]
  end
end
