# frozen_string_literal: true

class RenameUnitCurriculumToCurriculumProgram < ActiveRecord::Migration[5.2]
  def change
    rename_table :unit_curriculums, :curriculum_programs
  end
end
