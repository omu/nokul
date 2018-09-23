# frozen_string_literal: true

class CreateFriendlyIdSlugs < ActiveRecord::Migration[5.2]
  def change
    create_table :friendly_id_slugs do |t|
      t.string   :slug,           null: false, limit: 255
      t.integer  :sluggable_id,   null: false
      t.string   :sluggable_type, limit: 50
      t.string   :scope, limit: 255
      t.datetime :created_at
    end
    add_index :friendly_id_slugs, :sluggable_id
    add_index :friendly_id_slugs, [:slug, :sluggable_type]
    add_index :friendly_id_slugs, [:slug, :sluggable_type, :scope], unique: true
    add_index :friendly_id_slugs, :sluggable_type
  end
end
