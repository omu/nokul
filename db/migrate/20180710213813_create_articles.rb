class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.integer :yoksis_id, null: false
      t.integer :scope
      t.integer :review
      t.integer :index
      t.text :title
      t.text :authors
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
      t.text :access_link
      t.text :discipline
      t.string :keyword
      t.integer :special_issue
      t.integer :special_issue_name
      t.string :sponsored_by
      t.integer :author_id
      t.datetime :last_update
      t.integer :status
      t.integer :type
      t.float :incentive_point
      t.references :user, foreign_key: true
    end
  end
end
