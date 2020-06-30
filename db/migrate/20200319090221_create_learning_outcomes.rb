class CreateLearningOutcomes < ActiveRecord::Migration[6.0]
  def change
    create_table :learning_outcomes do |t|
      t.references :accreditation_standard, null: false, foreign_key: true
      t.references :parent, foreign_key: { to_table: :learning_outcomes }
      t.string :code
      t.string :name

      t.timestamps
    end

    add_length_constraint :learning_outcomes, :code, less_than_or_equal_to: 10
    add_length_constraint :learning_outcomes, :name, less_than_or_equal_to: 255

    add_presence_constraint :learning_outcomes, :code
    add_presence_constraint :learning_outcomes, :name

    add_unique_constraint :learning_outcomes, [:accreditation_standard_id, :code]
  end
end
