class CreateUniversityTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :university_types do |t|
      t.string :name
      t.integer :code
    end
  end
end
