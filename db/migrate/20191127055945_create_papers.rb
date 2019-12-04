# frozen_string_literal: true

class CreatePapers < ActiveRecord::Migration[6.0]
  def change
    create_table :papers do |t|
      t.text :access_link
      t.integer :activity
      t.integer :author_id
      t.string :authors
      t.integer :number_of_authors
      t.string :city
      t.references :country, foreign_key: true
      t.string :discipline
      t.string :doi
      t.string :issn
      t.float :incentive_point, default: 0
      t.string :issue
      t.text :keywords
      t.string :language_of_publication
      t.integer :first_page
      t.integer :last_page
      t.datetime :last_update
      t.string :name
      t.integer :presentation_type
      t.string :print_isbn
      t.integer :publication_status
      t.date :release_date
      t.integer :scope
      t.string :special_issue
      t.string :sponsored_by
      t.integer :type
      t.integer :type_of_release
      t.integer :volume
      t.references :user, null: false, foreign_key: true
      t.integer :yoksis_id
      t.timestamps
    end

    add_column :users, :papers_count, :integer, default: 0

    add_null_constraint :papers, :activity
    add_null_constraint :papers, :scope
    add_null_constraint :papers, :yoksis_id

    add_length_constraint :papers, :access_link, less_than_or_equal_to: 2000
    add_length_constraint :papers, :authors, less_than_or_equal_to: 255
    add_length_constraint :papers, :city, less_than_or_equal_to: 255
    add_length_constraint :papers, :discipline, less_than_or_equal_to: 255
    add_length_constraint :papers, :doi, less_than_or_equal_to: 255
    add_length_constraint :papers, :issn, less_than_or_equal_to: 255
    add_length_constraint :papers, :issue, less_than_or_equal_to: 255
    add_length_constraint :papers, :keywords, less_than_or_equal_to: 4000
    add_length_constraint :papers, :language_of_publication, less_than_or_equal_to: 255
    add_length_constraint :papers, :name, less_than_or_equal_to: 255
    add_length_constraint :papers, :print_isbn, less_than_or_equal_to: 255
    add_length_constraint :papers, :special_issue, less_than_or_equal_to: 255
    add_length_constraint :papers, :sponsored_by, less_than_or_equal_to: 255

    add_numericality_constraint :papers, :activity, greater_than_or_equal_to: 0
    add_numericality_constraint :papers, :author_id, greater_than_or_equal_to: 0
    add_numericality_constraint :papers, :number_of_authors, greater_than_or_equal_to: 0
    add_numericality_constraint :papers, :incentive_point, greater_than_or_equal_to: 0
    add_numericality_constraint :papers, :first_page, greater_than_or_equal_to: 0, less_than: 15_000
    add_numericality_constraint :papers, :last_page, greater_than_or_equal_to: 0, less_than: 15_000
    add_numericality_constraint :papers, :presentation_type, greater_than_or_equal_to: 0
    add_numericality_constraint :papers, :publication_status, greater_than_or_equal_to: 0
    add_numericality_constraint :papers, :scope, greater_than_or_equal_to: 0
    add_numericality_constraint :papers, :type, greater_than_or_equal_to: 0
    add_numericality_constraint :papers, :type_of_release, greater_than_or_equal_to: 0
    add_numericality_constraint :papers, :volume, greater_than_or_equal_to: 0
    add_numericality_constraint :papers, :yoksis_id, greater_than_or_equal_to: 0
  end
end
