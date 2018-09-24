# frozen_string_literal: true

class CreateUnitCurriculums < ActiveRecord::Migration[5.2]
  def change
    create_table :unit_curriculums do |t|
      t.references :unit
      t.references :curriculum
    end
  end
end
