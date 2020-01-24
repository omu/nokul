class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.integer :unit_id
      t.integer :icc_id
      t.integer :answer_id, default: 0
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
      t.string :explanation
      t.integer :status, default: 0

      t.timestamps
    end

    add_index :questions, :unit_id
    add_index :questions, :author_id
    add_index :questions, :editor_id
    add_index :questions, :master_id

    add_length_constraint :questions, :title, less_than_or_equal_to: 255
    add_length_constraint :questions, :explanation, less_than_or_equal_to: 400

    add_numericality_constraint :questions, :unit_id, greater_than_or_equal_to: 0
    add_numericality_constraint :questions, :icc_id, greater_than_or_equal_to: 0
    add_numericality_constraint :questions, :answer_id, greater_than_or_equal_to: 0
    add_numericality_constraint :questions, :author_id, greater_than_or_equal_to: 0
    add_numericality_constraint :questions, :editor_id, greater_than_or_equal_to: 0
    add_numericality_constraint :questions, :master_id, greater_than_or_equal_to: 0
    add_numericality_constraint :questions, :parent_id, greater_than_or_equal_to: 0
    add_numericality_constraint :questions, :source_book_id, greater_than_or_equal_to: 0

    add_presence_constraint :questions, :unit_id
    add_presence_constraint :questions, :icc_id
    add_presence_constraint :questions, :answer_id
    add_presence_constraint :questions, :author_id
    add_presence_constraint :questions, :source_book_id
    add_presence_constraint :questions, :use_count
    add_presence_constraint :questions, :bloom
    add_presence_constraint :questions, :degree
    add_presence_constraint :questions, :lang
    add_presence_constraint :questions, :title
    add_presence_constraint :questions, :status
  end
end
