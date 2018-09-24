# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :id_number,          null: false, limit: 255
      t.string :email,              null: false, limit: 255
      t.string :encrypted_password, null: false, default: '', limit: 255

      ## Recoverable
      t.string   :reset_password_token, limit: 255
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet     :current_sign_in_ip
      t.inet     :last_sign_in_ip
      t.datetime :password_changed_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

      # Custom fields
      t.string :slug, limit: 255
      t.string :preferred_language, default: 'tr', limit: 2
      t.integer :articles_count, null: false, default: 0
      t.integer :projects_count, null: false, default: 0
      t.jsonb :profile_preferences
      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :id_number,            unique: true
    add_index :users, :reset_password_token, unique: true
  end
end
