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

    add_presence_constraint :sdp_codes, :name

    add_null_constraint :sdp_codes, :main
    add_null_constraint :sdp_codes, :first
    add_null_constraint :sdp_codes, :second
    add_null_constraint :sdp_codes, :third
    add_null_constraint :sdp_codes, :name

    add_numericality_constraint :sdp_codes, :main,   greater_than_or_equal_to: 0
    add_numericality_constraint :sdp_codes, :first,  greater_than_or_equal_to: 0
    add_numericality_constraint :sdp_codes, :second, greater_than_or_equal_to: 0
    add_numericality_constraint :sdp_codes, :third,  greater_than_or_equal_to: 0

    add_length_constraint :sdp_codes, :name, less_than_or_equal_to: 255
  end
end
