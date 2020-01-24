class CreateQuestionChoices < ActiveRecord::Migration[6.0]
  def change
    create_table :question_choices do |t|
      t.integer :question_id
      t.string :content

      t.timestamps
    end

    add_index :question_choices, :question_id

    add_length_constraint :question_choices, :content, less_than_or_equal_to: 500

    add_numericality_constraint :question_choices, :question_id, greater_than_or_equal_to: 0

    add_presence_constraint :question_choices, :question_id
    add_presence_constraint :question_choices, :content
  end
end
