# frozen_string_literal: true

class CreateYoksisResponses < ActiveRecord::Migration[5.1]
  def change
    create_table :yoksis_responses do |t|
      t.string :name, null: false, limit: 255, comment: 'API endpoint, ie: Yoksis'
      t.string :endpoint, null: false, limit: 255, comment: 'API endpoint name, ie: Referanslar'
      t.string :action, null: false, limit: 255, comment: 'Endpoint action, ie: get_ogrenim_dili_response'
      t.string :sha1, null: false, limit: 40, comment: 'SHA1 hash of the API response'
      t.datetime :created_at, null: false
      t.datetime :syncronized_at
    end
  end
end
