class CreateYoksisResponses < ActiveRecord::Migration[5.1]
  def change
    create_table :yoksis_responses do |t|
      t.string :name, null: false
      t.string :endpoint, null: false
      t.string :action, null: false
      t.string :sha1, null: false
      t.datetime :created_at, null: false
      t.datetime :syncronized_at
    end
  end
end
