class RemoveStudentFromIdentity < ActiveRecord::Migration[6.0]
  def change
    remove_reference :identities, :student, foreign_key: true
  end
end
