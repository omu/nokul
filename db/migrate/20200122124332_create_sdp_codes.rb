class CreateSdpCodes < ActiveRecord::Migration[6.0]
  def change
    create_table :sdp_codes do |t|
      t.integer :main
      t.integer :first
      t.integer :second
      t.integer :third
      t.string :name

      t.timestamps
    end
  end
end
