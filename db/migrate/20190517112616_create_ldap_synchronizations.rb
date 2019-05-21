class CreateLdapSynchronizations < ActiveRecord::Migration[6.0]
  def change
    create_table :ldap_synchronizations do |t|
      t.references :user, null: false, foreign_key: true
      t.jsonb :values
      t.integer :status
      t.datetime :synchronized_at

      t.timestamps
    end

    add_numericality_constraint :ldap_synchronizations, :status, greater_than_or_equal_to: 0
  end
end
