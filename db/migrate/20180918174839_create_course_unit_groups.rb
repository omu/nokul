class CreateCourseUnitGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :course_unit_groups do |t|
      t.string :name, null: false
      t.integer :total_ects_condition, null: false
      t.references :unit, foreign_key: true
      t.references :course_group_type, foreign_key: true
      t.timestamps
    end
  end
end
