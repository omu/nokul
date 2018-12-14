# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :id_number
      t.string :email
      t.string :encrypted_password, default: ''

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet     :current_sign_in_ip
      t.inet     :last_sign_in_ip
      t.datetime :password_changed_at, default: -> { 'CURRENT_TIMESTAMP' }

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      t.integer  :failed_attempts, default: 0 # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at

      # Custom fields
      t.string :slug
      t.string :preferred_language, default: 'tr'
      t.integer :articles_count, default: 0
      t.integer :projects_count, default: 0
      t.jsonb :profile_preferences
      t.timestamps
    end

    add_presence_constraint :users, :id_number
    add_presence_constraint :users, :email
    add_null_constraint :users, :encrypted_password
    add_null_constraint :users, :sign_in_count
    add_null_constraint :users, :password_changed_at
    add_null_constraint :users, :failed_attempts
    add_null_constraint :users, :articles_count
    add_null_constraint :users, :projects_count
    add_null_constraint :users, :created_at
    add_null_constraint :users, :updated_at

    add_length_constraint :users, :id_number, equal_to: 11
    add_length_constraint :users, :email, less_than_or_equal_to: 255
    add_length_constraint :users, :encrypted_password, less_than_or_equal_to: 255
    add_length_constraint :users, :reset_password_token, less_than_or_equal_to: 255
    add_length_constraint :users, :slug, less_than_or_equal_to: 255
    add_length_constraint :users, :preferred_language, equal_to: 2

    add_numericality_constraint :users, :sign_in_count,
                                        greater_than_or_equal_to: 0
    add_numericality_constraint :users, :failed_attempts,
                                        greater_than_or_equal_to: 0
    add_numericality_constraint :users, :articles_count,
                                        greater_than_or_equal_to: 0
    add_numericality_constraint :users, :projects_count,
                                        greater_than_or_equal_to: 0

    add_unique_constraint :users, :email
    add_unique_constraint :users, :id_number

    add_index :users, :email,                unique: true
    add_index :users, :id_number,            unique: true
    add_index :users, :reset_password_token, unique: true
  end
end
