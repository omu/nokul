class CreateUnitCurriculums < ActiveRecord::Migration[5.2]
  def change
    create_table :unit_curriculums do |t|
      t.references :unit, foreign_key: true
      t.references :curriculum, foreign_key: true
    end
  end
end
