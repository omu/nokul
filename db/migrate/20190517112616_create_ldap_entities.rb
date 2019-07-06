class CreateLdapEntities < ActiveRecord::Migration[6.0]
  def change
    create_table :ldap_entities do |t|
      t.references :user, null: false, foreign_key: true
      t.jsonb :values
      t.string :dn
      t.integer :status, default: 0
      t.datetime :synchronized_at

      t.timestamps
    end

    add_numericality_constraint :ldap_entities, :status, greater_than_or_equal_to: 0
    add_presence_constraint :ldap_entities, :dn
    add_length_constraint :ldap_entities, :dn, less_than_or_equal_to: 255
  end
end
