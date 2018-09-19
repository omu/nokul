class CreateProspectiveStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :prospective_students do |t|
      t.string :id_number, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :fathers_name
      t.string :mothers_name
      t.date :date_of_birth
      t.integer :gender
      t.integer :nationality
      t.string :place_of_birth
      t.string :registration_city
      t.string :registration_district
      t.string :school_code
      t.string :school_type
      t.string :school_branch
      t.integer :type_of_education
      t.integer :high_school_graduation_year
      t.integer :placement_type
      t.float :exam_score
      t.references :language
      t.text :address
      t.string :home_phone
      t.string :mobile_phone
      t.string :email
      t.references :student_disability_type
      t.boolean :top_student, default: false
      t.float :placement_score
      t.integer :placement_rank
      t.references :unit
      t.integer :preference_order
      t.string :placement_score_type
      t.integer :additional_score
      t.boolean :meb_status
      t.datetime :meb_status_date
      t.boolean :military_status
      t.datetime :military_status_date
      t.boolean :obs_status
      t.datetime :obs_status_date
      t.string :obs_registered_program
      t.timestamps
    end
  end
end
