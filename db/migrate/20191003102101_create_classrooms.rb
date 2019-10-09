class CreateClassrooms < ActiveRecord::Migration[6.0]
  def change
    create_table :classrooms do |t|
      t.integer :meksis_id
      t.string :name
      t.string :code
      t.integer :room_number
      t.integer :student_capacity
      t.integer :exam_capacity
      t.float :available_space
      t.float :height
      t.float :width
      t.float :length
      t.float :volume
      t.references :place_type, null: false, foreign_key: true
      t.references :building, null: false, foreign_key: true

      t.timestamps
    end

    add_presence_constraint :classrooms, :name
    add_presence_constraint :classrooms, :code

    add_null_constraint :classrooms, :meksis_id

    add_length_constraint :classrooms, :name, less_than_or_equal_to: 255
    add_length_constraint :classrooms, :code, less_than_or_equal_to: 255

    add_numericality_constraint :classrooms, :meksis_id, greater_than_or_equal_to: 1

    add_unique_constraint :classrooms, :name
    add_unique_constraint :classrooms, :meksis_id
  end
end
