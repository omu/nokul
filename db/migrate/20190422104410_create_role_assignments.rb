class CreateRoleAssignments < ActiveRecord::Migration[6.0]
  def change
    create_table :role_assignments do |t|
      t.references :role, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :role_assignments,
              %i[user_id role_id],
              unique: true,
              name: 'index_user_id_and_role_id'
  end
end
