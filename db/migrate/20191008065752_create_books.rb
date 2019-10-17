# frozen_string_literal: true

class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.text :access_link
      t.integer :activity
      t.integer :author_id
      t.string :authors
      t.integer :chapter_first_page
      t.integer :chapter_last_page
      t.string :chapter_name
      t.string :city
      t.integer :contribution_rate
      t.references :country, foreign_key: true
      t.string :discipline
      t.string :editor_name
      t.float :incentive_point
      t.string :isbn
      t.text :keywords
      t.string :language_of_publication
      t.datetime :last_update
      t.string :name
      t.integer :number_of_authors
      t.integer :number_of_copy
      t.integer :number_of_page
      t.string :publisher
      t.integer :scope
      t.integer :type
      t.integer :type_of_release
      t.references :user, null: false, foreign_key: true
      t.integer :year
      t.integer :yoksis_id
      t.timestamps
    end

    add_column :users, :books_count, :integer, default: 0

    add_null_constraint :books, :activity
    add_null_constraint :books, :scope
    add_null_constraint :books, :yoksis_id

    add_length_constraint :books, :access_link, less_than_or_equal_to: 2000
    add_length_constraint :books, :authors, less_than_or_equal_to: 255
    add_length_constraint :books, :chapter_name, less_than_or_equal_to: 255
    add_length_constraint :books, :city, less_than_or_equal_to: 255
    add_length_constraint :books, :discipline, less_than_or_equal_to: 255
    add_length_constraint :books, :editor_name, less_than_or_equal_to: 255
    add_length_constraint :books, :isbn, less_than_or_equal_to: 255
    add_length_constraint :books, :keywords, less_than_or_equal_to: 4000
    add_length_constraint :books, :name, less_than_or_equal_to: 255
    add_length_constraint :books, :language_of_publication, less_than_or_equal_to: 255
    add_length_constraint :books, :publisher, less_than_or_equal_to: 255

    add_numericality_constraint :books, :activity, greater_than_or_equal_to: 0
    add_numericality_constraint :books, :author_id, greater_than_or_equal_to: 0
    add_numericality_constraint :books, :chapter_first_page, greater_than_or_equal_to: 0
    add_numericality_constraint :books, :chapter_last_page, greater_than_or_equal_to: 0
    add_numericality_constraint :books, :contribution_rate, greater_than_or_equal_to: 0
    add_numericality_constraint :books, :incentive_point, greater_than_or_equal_to: 0
    add_numericality_constraint :books, :number_of_authors, greater_than_or_equal_to: 0
    add_numericality_constraint :books, :number_of_copy, greater_than_or_equal_to: 0
    add_numericality_constraint :books, :number_of_page, greater_than_or_equal_to: 0
    add_numericality_constraint :books, :scope, greater_than_or_equal_to: 0
    add_numericality_constraint :books, :type, greater_than_or_equal_to: 0
    add_numericality_constraint :books, :type_of_release, greater_than_or_equal_to: 0
    add_numericality_constraint :books, :year, greater_than_or_equal_to: 1950, less_than_or_equal_to: 2050
    add_numericality_constraint :books, :yoksis_id, greater_than_or_equal_to: 0
  end
end
