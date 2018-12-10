# frozen_string_literal: true

class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.integer :yoksis_id
      t.string :name
      t.string :subject
      t.integer :status
      t.date :start_date
      t.date :end_date
      t.string :budget
      t.string :duty
      t.string :type
      t.string :currency
      t.datetime :last_update
      t.integer :activity
      t.integer :scope
      t.string :title
      t.integer :unit_id # TODO: Migrate to reference maybe?
      t.float :incentive_point
      t.references :user,
                   null: false,
                   foreign_key: true
      t.timestamps
    end

    add_presence_constraint :projects, :yoksis_id
    add_presence_constraint :projects, :name

    add_length_constraint :projects, :name, less_than_or_equal_to: 65535
    add_length_constraint :projects, :subject, less_than_or_equal_to: 65535
    add_length_constraint :projects, :budget, less_than_or_equal_to: 255
    add_length_constraint :projects, :duty, less_than_or_equal_to: 255
    add_length_constraint :projects, :type, less_than_or_equal_to: 255
    add_length_constraint :projects, :currency, less_than_or_equal_to: 255
    add_length_constraint :projects, :title, less_than_or_equal_to: 255

    add_numericality_constraint :projects, :yoksis_id,
                                           greater_than_or_equal_to: 0
    add_numericality_constraint :projects, :status,
                                           greater_than_or_equal_to: 0
    add_numericality_constraint :projects, :activity,
                                           greater_than_or_equal_to: 0
    add_numericality_constraint :projects, :scope,
                                           greater_than_or_equal_to: 0
  end
end
