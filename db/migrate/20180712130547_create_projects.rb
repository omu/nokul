class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.integer :yoksis_id, null: false
      t.text :name
      t.text :subject
      t.integer :status
      t.date :bastar
      t.date :bittar
      t.string :budget
      t.string :duty
      t.string :type
      t.string :currency
      t.datetime :last_update
      t.integer :activity
      t.integer :scope
      t.string :title
      t.integer :unit_id
      t.float :incentive_point
      t.references :user, foreign_key: true
    end
  end
end
