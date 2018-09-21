class RemoveYoksisCodeFromLanguages < ActiveRecord::Migration[5.2]
  def change
    remove_column :languages, :yoksis_code, :integer
  end
end
