# frozen_string_literal: true

class RenameNumberOfSemestersToCurriculum < ActiveRecord::Migration[5.2]
  def up
    rename_column :curriculums, :number_of_semesters, :semesters_count
    change_column :curriculums, :semesters_count, :integer, default: 0
  end

  def down
    rename_column :curriculums, :semesters_count, :number_of_semesters
    change_column :curriculums, :number_of_semesters, :integer, default: 0
  end
end
