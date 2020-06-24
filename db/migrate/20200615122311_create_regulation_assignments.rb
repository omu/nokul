class CreateRegulationAssignments < ActiveRecord::Migration[6.0]
  def change
    create_table :regulation_assignments do |t|
      t.references :regulation, null: false, foreign_key: true, type: :uuid
      t.references :assignable, polymorphic: true, null: false, index: {
        name: 'index_regulation_assignments_assignable'
      }
    end
  end
end
