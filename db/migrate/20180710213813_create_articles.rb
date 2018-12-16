# frozen_string_literal: true

class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.integer :yoksis_id
      t.integer :scope
      t.integer :review
      t.integer :index
      t.string :title
      t.string :authors
      t.integer :number_of_authors
      t.integer :country
      t.string :city
      t.string :journal
      t.string :language_of_publication
      t.integer :month
      t.integer :year
      t.string :volume
      t.string :issue
      t.integer :first_page
      t.integer :last_page
      t.string :doi
      t.string :issn
      t.integer :access_type
      t.string :access_link
      t.string :discipline
      t.string :keyword
      t.integer :special_issue
      t.string :special_issue_name
      t.string :sponsored_by
      t.integer :author_id
      t.datetime :last_update
      t.integer :status
      t.integer :type
      t.float :incentive_point, default: 0
      t.references :user,
                   null: false,
                   foreign_key: true
      t.timestamps
    end

    add_null_constraint :articles, :yoksis_id
    add_presence_constraint :articles, :title
    add_presence_constraint :articles, :authors

    add_length_constraint :articles, :title, less_than_or_equal_to: 65_535
    add_length_constraint :articles, :authors, less_than_or_equal_to: 65_535
    add_length_constraint :articles, :city, less_than_or_equal_to: 255
    add_length_constraint :articles, :journal, less_than_or_equal_to: 255
    add_length_constraint :articles, :language_of_publication, less_than_or_equal_to: 255
    add_length_constraint :articles, :volume, less_than_or_equal_to: 255
    add_length_constraint :articles, :issue, less_than_or_equal_to: 255
    add_length_constraint :articles, :doi, less_than_or_equal_to: 255
    add_length_constraint :articles, :issn, less_than_or_equal_to: 255
    add_length_constraint :articles, :access_link, less_than_or_equal_to: 65_535
    add_length_constraint :articles, :discipline, less_than_or_equal_to: 65_535
    add_length_constraint :articles, :keyword, less_than_or_equal_to: 255
    add_length_constraint :articles, :sponsored_by, less_than_or_equal_to: 255
    add_length_constraint :articles, :special_issue_name, less_than_or_equal_to: 255

    add_numericality_constraint :articles, :yoksis_id,
                                greater_than_or_equal_to: 0
    add_numericality_constraint :articles, :type,
                                greater_than_or_equal_to: 0
    add_numericality_constraint :articles, :scope,
                                greater_than_or_equal_to: 0
    add_numericality_constraint :articles, :number_of_authors,
                                greater_than_or_equal_to: 0
    add_numericality_constraint :articles, :status,
                                greater_than_or_equal_to: 0
    add_numericality_constraint :articles, :review,
                                greater_than_or_equal_to: 0
    add_numericality_constraint :articles, :index,
                                greater_than_or_equal_to: 0
    add_numericality_constraint :articles, :country,
                                greater_than_or_equal_to: 0
    add_numericality_constraint :articles, :month,
                                greater_than_or_equal_to: 1,
                                less_than_or_equal_to: 12
    add_numericality_constraint :articles, :year,
                                greater_than_or_equal_to: 1950,
                                less_than_or_equal_to: 2050
    add_numericality_constraint :articles, :first_page,
                                greater_than_or_equal_to: 0,
                                less_than: 15_000
    add_numericality_constraint :articles, :last_page,
                                greater_than_or_equal_to: 0,
                                less_than: 15_000
    add_numericality_constraint :articles, :access_type,
                                greater_than_or_equal_to: 0
    add_numericality_constraint :articles, :special_issue,
                                greater_than_or_equal_to: 0
    add_numericality_constraint :articles, :author_id,
                                greater_than_or_equal_to: 0
    add_numericality_constraint :articles, :incentive_point,
                                greater_than_or_equal_to: 0
  end
end
