# frozen_string_literal: true

class DropYoksisResponses < ActiveRecord::Migration[5.2]
  def change
    drop_table :yoksis_responses do |t|
      t.string :name
      t.string :endpoint
      t.string :action
      t.string :sha1
      t.datetime :created_at
      t.datetime :syncronized_at
    end
  end
end
