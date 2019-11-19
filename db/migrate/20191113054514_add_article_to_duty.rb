# frozen_string_literal: true

class AddArticleToDuty < ActiveRecord::Migration[6.0]
  def change
    add_column :duties, :article, :integer

    add_numericality_constraint :duties, :article, greater_than_or_equal_to: 1
  end
end
