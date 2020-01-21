class AddPrivilegesToRolePermission < ActiveRecord::Migration[6.0]
  def change
    add_column :role_permissions, :privileges, :integer, null: false, default: 0, limit: 8
  end
end
