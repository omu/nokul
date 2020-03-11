class CreateOutcomes < ActiveRecord::Migration[6.0]
  def change
    create_table :outcomes do |t|
      t.references :unit, null: false, foreign_key: true
      t.references :parent, foreign_key: { to_table: :outcomes }
      t.string :code
      t.string :name

      t.timestamps
    end

    add_length_constraint :outcomes, :code, less_than_or_equal_to: 10
    add_length_constraint :outcomes, :name, less_than_or_equal_to: 255

    add_presence_constraint :outcomes, :code
    add_presence_constraint :outcomes, :name

    add_unique_constraint :outcomes, [:unit_id, :code]
  end
end
