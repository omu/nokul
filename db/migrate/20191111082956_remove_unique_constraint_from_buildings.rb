class RemoveUniqueConstraintFromBuildings < ActiveRecord::Migration[6.0]
  def change
    remove_unique_constraint :buildings, :latitude
    remove_unique_constraint :buildings, :longitude
  end
end
