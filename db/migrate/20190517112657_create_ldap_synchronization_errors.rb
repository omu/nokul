class CreateLdapSynchronizationErrors < ActiveRecord::Migration[6.0]
  def change
    create_table :ldap_synchronization_errors do |t|
      t.references :ldap_synchronization, null: false, foreign_key: true
      t.text :description
      t.boolean :resolved

      t.timestamps
    end

    add_presence_constraint :ldap_synchronization_errors, :description
    add_length_constraint :ldap_synchronization_errors, :description, less_than_or_equal_to: 65_535
    add_null_constraint :ldap_synchronization_errors, :resolved
  end
end
