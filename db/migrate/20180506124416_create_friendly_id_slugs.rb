# frozen_string_literal: true

class CreateFriendlyIdSlugs < ActiveRecord::Migration[5.2]
  def change
    create_table :friendly_id_slugs do |t|
      t.string   :slug
      t.integer  :sluggable_id
      t.string   :sluggable_type
      t.string   :scope
      t.datetime :created_at
    end

    add_presence_constraint :friendly_id_slugs, :slug
    add_presence_constraint :friendly_id_slugs, :sluggable_id

    add_length_constraint :friendly_id_slugs, :slug, less_than_or_equal_to: 255
    add_length_constraint :friendly_id_slugs, :sluggable_type, less_than_or_equal_to: 255
    add_length_constraint :friendly_id_slugs, :scope, less_than_or_equal_to: 255

    add_index :friendly_id_slugs, :sluggable_id
    add_index :friendly_id_slugs, [:slug, :sluggable_type]
    add_index :friendly_id_slugs, [:slug, :sluggable_type, :scope], unique: true
    add_index :friendly_id_slugs, :sluggable_type
  end
end
