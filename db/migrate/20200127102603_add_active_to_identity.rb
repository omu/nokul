class AddActiveToIdentity < ActiveRecord::Migration[6.0]
  def change
    add_column :identities, :active, :boolean, default: true
    add_null_constraint :identities, :active
  end
end
