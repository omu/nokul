# frozen_string_literal: true

class CreateActiveStorageTables < ActiveRecord::Migration[5.2]
  def change
    create_table :active_storage_blobs do |t|
      t.string   :key
      t.string   :filename
      t.string   :content_type
      t.string   :metadata
      t.bigint   :byte_size
      t.string   :checksum
      t.datetime :created_at
      t.index [ :key ], unique: true
    end

    create_table :active_storage_attachments do |t|
      t.string     :name
      t.references :record, polymorphic: true, index: false
      t.references :blob
      t.datetime :created_at
      t.index [ :record_type, :record_id, :name, :blob_id ], name: "index_active_storage_attachments_uniqueness", unique: true
    end

    add_presence_constraint :active_storage_blobs, :key
    add_presence_constraint :active_storage_blobs, :filename
    add_presence_constraint :active_storage_blobs, :byte_size
    add_presence_constraint :active_storage_blobs, :checksum
    add_presence_constraint :active_storage_blobs, :created_at
    add_presence_constraint :active_storage_attachments, :name
    add_presence_constraint :active_storage_attachments, :record
    add_presence_constraint :active_storage_attachments, :blob
    add_presence_constraint :active_storage_attachments, :created_at

    add_length_constraint :active_storage_blobs, :key, less_than_or_equal_to: 255
  end
end
