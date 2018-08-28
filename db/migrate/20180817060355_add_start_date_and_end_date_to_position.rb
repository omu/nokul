class AddStartDateAndEndDateToPosition < ActiveRecord::Migration[5.2]
  def change
    add_column :positions, :start_date, :date
    add_column :positions, :end_date, :date
  end
end
