class CreateCertifications < ActiveRecord::Migration[5.2]
  def change
    create_table :certifications do |t|
      t.integer :yoksis_id, null: false
      t.integer :type, null: false, default: 1
      t.string :name
      t.text :content
      t.string :location
      t.integer :scope
      t.string :duration
      t.date :start_date
      t.date :end_date
      t.string :title
      t.integer :number_of_authors
      t.string :city_and_country
      t.datetime :last_update
      t.float :incentive_point
      t.integer :status
      t.references :user, foreign_key: true
    end
  end
end
