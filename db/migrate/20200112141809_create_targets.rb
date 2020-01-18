class CreateTargets < ActiveRecord::Migration[6.0]
  def change
    create_table :targets do |t|
      t.integer :course_id, :null :false
      t.integer :icc_id,    :null :false

      t.timestamps
    end
  end

  add_index :targets, [:course_id, :icc_id], :unique :true
end
