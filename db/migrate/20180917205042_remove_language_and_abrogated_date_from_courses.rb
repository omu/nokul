class RemoveLanguageAndAbrogatedDateFromCourses < ActiveRecord::Migration[5.2]
  def change
    remove_column :courses, :language, :string
    remove_column :courses, :abrogated_date, :date
  end
end
