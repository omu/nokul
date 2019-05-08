class CreateScopeAssignments < ActiveRecord::Migration[6.0]
  def change
    create_table :scope_assignments do |t|
      t.references :query_store, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
