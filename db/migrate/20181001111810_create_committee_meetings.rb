class CreateCommitteeMeetings < ActiveRecord::Migration[5.2]
  def change
    create_table :committee_meetings do |t|
      t.integer :meeting_no, null: false
      t.date :meeting_date, null: false
      t.integer :year, null: false
      t.references :unit
      t.timestamps
    end
  end
end
