class CreateYoksisResponses < ActiveRecord::Migration[5.1]
  def change
    create_table :yoksis_responses do |t|
      t.string :name, null: false, comment: 'API endpoint, ie: Yoksis'
      t.string :endpoint, null: false, comment: 'API endpoint name, ie: Referanslar'
      t.string :action, null: false, comment: 'Endpoint action, ie: get_ogrenim_dili_response'
      t.string :sha1, null: false, comment: 'SHA1 hash of the API response'
      t.datetime :created_at, null: false
      t.datetime :syncronized_at
    end
  end
end
