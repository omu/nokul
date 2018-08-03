class RenameNameFieldOfIdentityAndAddressToType < ActiveRecord::Migration[5.2]
  def change
    rename_column :addresses, :name, :type
    rename_column :identities, :name, :type
  end
end
