class CreateRegulations < ActiveRecord::Migration[6.0]
  def change
    create_table :regulations, id: :uuid do |t|
      t.string :class_name
      t.date :effective_date
      t.datetime :repealed_at

      t.timestamps
    end

    add_presence_constraint :regulations, :class_name
    add_length_constraint :regulations, :class_name, less_than_or_equal_to: 255
  end
end
