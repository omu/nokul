class RenameCourseUnitGroupToCourseGroup < ActiveRecord::Migration[5.2]
  def change
    rename_table :course_unit_groups, :course_groups
    rename_column :group_courses, :course_unit_group_id, :course_group_id
  end
end
