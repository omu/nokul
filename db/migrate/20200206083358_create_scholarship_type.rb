class CreateScholarshipType < ActiveRecord::Migration[6.0]
  def change
    create_table :scholarship_types do |t|
      t.string :name
      t.boolean :active, default: true
    end

    add_null_constraint :scholarship_types, :active
    add_presence_constraint :scholarship_types, :name
    add_length_constraint :scholarship_types, :name, less_than_or_equal_to: 255
  end
end
