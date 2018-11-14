# frozen_string_literal: true

class DropYoksisResponses < ActiveRecord::Migration[5.2]
  def change
    drop_table :yoksis_responses
  end
end
