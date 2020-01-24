class CreateSourceBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :source_books do |t|
      t.integer :unit_id
      t.integer :status, default: 0
      t.integer :editon
      t.integer :publish_year
      t.string :name
      t.string :isbn
      t.string :author
      t.string :image
      t.string :explanation

      t.timestamps
    end

    add_index :source_books, :unit_id
    add_index :source_books, :name
    add_index :source_books, :isbn
    add_index :source_books, :author

    add_length_constraint :source_books, :name, less_than_or_equal_to: 100
    add_length_constraint :source_books, :isbn, less_than_or_equal_to: 50
    add_length_constraint :source_books, :author, less_than_or_equal_to: 150
    add_length_constraint :source_books, :image, less_than_or_equal_to: 100
    add_length_constraint :source_books, :explanation, less_than_or_equal_to: 400

    add_numericality_constraint :source_books, :unit_id, greater_than_or_equal_to: 0

    add_presence_constraint :source_books, :unit_id
    add_presence_constraint :source_books, :status
    add_presence_constraint :source_books, :editon
    add_presence_constraint :source_books, :publish_year
    add_presence_constraint :source_books, :name
    add_presence_constraint :source_books, :isbn
    add_presence_constraint :source_books, :author
    add_presence_constraint :source_books, :image
    add_presence_constraint :source_books, :explanation
  end
end
