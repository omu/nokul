# frozen_string_literal: true

class CreateActiveStorageTables < ActiveRecord::Migration[5.2]
  def change
    create_table :active_storage_blobs do |t|
      t.string   :key,        null: false, limit: 255
      t.string   :filename,   null: false, limit: 255
      t.string   :content_type, limit: 255
      t.text     :metadata, limit: 65535
      t.bigint   :byte_size,  null: false
      t.string   :checksum,   null: false, limit: 255
      t.datetime :created_at, null: false

      t.index [ :key ], unique: true
    end

    create_table :active_storage_attachments do |t|
      t.string     :name,     null: false, limit: 255
      t.references :record,   null: false, polymorphic: true, index: false
      t.references :blob,     null: false
      t.datetime :created_at, null: false

      t.index [ :record_type, :record_id, :name, :blob_id ], name: "index_active_storage_attachments_uniqueness", unique: true
    end
  end
end
