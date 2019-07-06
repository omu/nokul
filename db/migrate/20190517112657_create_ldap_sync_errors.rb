class CreateLdapSyncErrors < ActiveRecord::Migration[6.0]
  def change
    create_table :ldap_sync_errors do |t|
      t.references :ldap_entity, null: false, foreign_key: true
      t.text :description
      t.boolean :resolved, default: false

      t.timestamps
    end

    add_presence_constraint :ldap_sync_errors, :description
    add_length_constraint :ldap_sync_errors, :description, less_than_or_equal_to: 65_535
    add_null_constraint :ldap_sync_errors, :resolved
  end
end
