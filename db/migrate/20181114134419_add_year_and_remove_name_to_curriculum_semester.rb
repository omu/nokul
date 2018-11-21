class AddYearAndRemoveNameToCurriculumSemester < ActiveRecord::Migration[5.2]
  def change
    add_column :curriculum_semesters, :year, :integer
    remove_column :curriculum_semesters, :name, :string, limit: 255
  end
end
