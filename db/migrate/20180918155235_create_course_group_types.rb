class CreateCourseGroupTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :course_group_types do |t|
      t.string :name, null: false
      t.timestamps
    end
  end
end
