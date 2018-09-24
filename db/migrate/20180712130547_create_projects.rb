# frozen_string_literal: true

class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.integer :yoksis_id, null: false
      t.text :name, limit: 65535
      t.text :subject, limit: 65535
      t.integer :status
      t.date :start_date
      t.date :end_date
      t.string :budget, limit: 255
      t.string :duty, limit: 255
      t.string :type, limit: 255
      t.string :currency, limit: 255
      t.datetime :last_update
      t.integer :activity
      t.integer :scope
      t.string :title, limit: 255
      t.integer :unit_id
      t.float :incentive_point
      t.references :user
      t.timestamps
    end
  end
end
