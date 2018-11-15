class RenameUnitCurriculumToCurriculumProgram < ActiveRecord::Migration[5.2]
  def up
    rename_table :unit_curriculums, :curriculum_programs
  end

  def down
    rename_table :curriculum_programs, :unit_curriculums
  end
end
