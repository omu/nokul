# frozen_string_literal: true

class CreateCertifications < ActiveRecord::Migration[5.2]
  def change
    create_table :certifications do |t|
      t.integer :yoksis_id, null: false
      t.integer :type, null: false, default: 1
      t.string :name, limit: 255
      t.text :content, limit: 65535
      t.string :location, limit: 255
      t.integer :scope
      t.string :duration, limit: 255
      t.date :start_date
      t.date :end_date
      t.string :title, limit: 255
      t.integer :number_of_authors
      t.string :city_and_country, limit: 255
      t.datetime :last_update
      t.float :incentive_point
      t.integer :status
      t.references :user
      t.timestamps
    end
  end
end
