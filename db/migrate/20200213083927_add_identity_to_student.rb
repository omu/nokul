class AddIdentityToStudent < ActiveRecord::Migration[6.0]
  def change
    add_reference :students, :identity, null: false, foreign_key: true
  end
end
