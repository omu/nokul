class CreateQueryStores < ActiveRecord::Migration[6.0]
  def change
    create_table :query_stores do |t|
      t.string :name
      t.string :scope_name
      t.jsonb :parameters
      t.integer :type

      t.timestamps
    end

    add_index :query_stores, %I[scope_name]

    add_presence_constraint :query_stores, :name
    add_presence_constraint :query_stores, :scope_name

    add_length_constraint :query_stores, :name,       less_than_or_equal_to: 255
    add_length_constraint :query_stores, :scope_name, less_than_or_equal_to: 255

    add_numericality_constraint :query_stores, :type, greater_than_or_equal_to: 0
  end
end
