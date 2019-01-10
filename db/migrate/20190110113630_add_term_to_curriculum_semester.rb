class AddTermToCurriculumSemester < ActiveRecord::Migration[5.2]
  def change
    add_column :curriculum_semesters, :term, :integer

    add_null_constraint :curriculum_semesters, :term
    add_numericality_constraint :curriculum_semesters, :term, greater_than_or_equal_to: 0
  end
end
