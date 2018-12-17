# frozen_string_literal: true

class CreateCalendarUnitTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :calendar_unit_types do |t|
      t.references :calendar_type,
                   foreign_key: true,
                   null: false
      t.references :unit_type,
                   foreign_key: true,
                   null: false
    end
  end
end
