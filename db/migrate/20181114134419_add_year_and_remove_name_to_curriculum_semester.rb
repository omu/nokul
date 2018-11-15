class AddYearAndRemoveNameToCurriculumSemester < ActiveRecord::Migration[5.2]
  def up
    add_column :curriculum_semesters, :year, :integer
    remove_column :curriculum_semesters, :name
  end

  def down
    add_column :curriculum_semesters, :name, :string, limit: 255
    remove_column :curriculum_semesters, :year
  end
end
