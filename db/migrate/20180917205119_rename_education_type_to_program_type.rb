class RenameEducationTypeToProgramType < ActiveRecord::Migration[5.2]
  def change
    rename_column :courses, :education_type, :program_type
  end
end
