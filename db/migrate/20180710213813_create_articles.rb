# frozen_string_literal: true

class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.integer :yoksis_id, null: false
      t.integer :scope
      t.integer :review
      t.integer :index
      t.text :title, limit: 65535
      t.text :authors, limit: 65535
      t.integer :number_of_authors
      t.integer :country
      t.string :city, limit: 255
      t.string :journal, limit: 255
      t.string :language_of_publication, limit: 255
      t.integer :month
      t.integer :year
      t.string :volume, limit: 255
      t.string :issue, limit: 255
      t.integer :first_page
      t.integer :last_page
      t.string :doi, limit: 255
      t.string :issn, limit: 255
      t.integer :access_type
      t.text :access_link, limit: 65535
      t.text :discipline, limit: 65535
      t.string :keyword, limit: 255
      t.integer :special_issue
      t.integer :special_issue_name
      t.string :sponsored_by, limit: 255
      t.integer :author_id
      t.datetime :last_update
      t.integer :status
      t.integer :type
      t.float :incentive_point
      t.references :user
      t.timestamps
    end
  end
end
