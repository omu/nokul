class CreateVerifications < ActiveRecord::Migration[6.1]
  def change
    create_table :verifications do |t|
      t.integer :code
      t.boolean :verified, default: false
      t.string  :mobile_phone

      t.timestamps
    end

    add_null_constraint :verifications, :mobile_phone
    add_null_constraint :verifications, :code

    add_index :verifications, :mobile_phone, unique: true
  end
end
