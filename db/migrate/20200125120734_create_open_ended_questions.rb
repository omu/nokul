class CreateOpenEndedQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :open_ended_questions do |t|
      t.integer :unit_id
      t.integer :icc_id
      t.integer :author_id
      t.integer :editor_id
      t.integer :master_id
      t.integer :parent_id
      t.integer :source_book_id
      t.integer :use_count, default: 0
      t.integer :bloom, default: 1
      t.integer :degree, default: 1
      t.integer :lang, default: 0
      t.string :image
      t.text :title
      t.text :answer
      t.string :explanation
      t.integer :status, default: 0

      t.timestamps
    end

    add_index :open_ended_questions, :unit_id
    add_index :open_ended_questions, :author_id
    add_index :open_ended_questions, :editor_id
    add_index :open_ended_questions, :master_id

    add_length_constraint :open_ended_questions, :title, greater_than: 0
    add_length_constraint :open_ended_questions, :answer, greater_than: 0
    add_length_constraint :open_ended_questions, :explanation, less_than_or_equal_to: 400

    add_numericality_constraint :open_ended_questions, :unit_id, greater_than_or_equal_to: 0
    add_numericality_constraint :open_ended_questions, :icc_id, greater_than_or_equal_to: 0
    add_numericality_constraint :open_ended_questions, :answer_id, greater_than_or_equal_to: 0
    add_numericality_constraint :open_ended_questions, :author_id, greater_than_or_equal_to: 0
    add_numericality_constraint :open_ended_questions, :editor_id, greater_than_or_equal_to: 0
    add_numericality_constraint :open_ended_questions, :master_id, greater_than_or_equal_to: 0
    add_numericality_constraint :open_ended_questions, :parent_id, greater_than_or_equal_to: 0
    add_numericality_constraint :open_ended_questions, :source_book_id, greater_than_or_equal_to: 0

    add_presence_constraint :open_ended_questions, :unit_id
    add_presence_constraint :open_ended_questions, :icc_id
    add_presence_constraint :open_ended_questions, :answer_id
    add_presence_constraint :open_ended_questions, :author_id
    add_presence_constraint :open_ended_questions, :source_book_id
    add_presence_constraint :open_ended_questions, :use_count
    add_presence_constraint :open_ended_questions, :bloom
    add_presence_constraint :open_ended_questions, :degree
    add_presence_constraint :open_ended_questions, :lang
    add_presence_constraint :open_ended_questions, :title
    add_presence_constraint :open_ended_questions, :status
  end
end
