# frozen_string_literal: true

class CreateProspectiveStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :prospective_students do |t|
      t.string :id_number, null: false, limit: 255
      t.string :first_name, null: false, limit: 255
      t.string :last_name, null: false, limit: 255
      t.string :fathers_name, limit: 255
      t.string :mothers_name, limit: 255
      t.date :date_of_birth
      t.integer :gender
      t.integer :nationality
      t.string :place_of_birth, limit: 255
      t.string :registration_city, limit: 255
      t.string :registration_district, limit: 255
      t.string :high_school_code, limit: 255
      t.references :high_school_type
      t.string :high_school_branch, limit: 255
      t.integer :state_of_education
      t.integer :high_school_graduation_year
      t.integer :placement_type
      t.float :exam_score
      t.references :language
      t.string :address, limit: 255
      t.string :home_phone, limit: 255
      t.string :mobile_phone, limit: 255
      t.string :email, limit: 255
      t.references :student_disability_type
      t.boolean :top_student, null: false, default: false
      t.float :placement_score
      t.integer :placement_rank
      t.references :unit
      t.integer :preference_order
      t.string :placement_score_type, limit: 255
      t.integer :additional_score
      t.boolean :meb_status, null: false, default: false
      t.datetime :meb_status_date
      t.boolean :military_status, null: false, default: false
      t.datetime :military_status_date
      t.boolean :obs_status, null: false, default: false
      t.datetime :obs_status_date
      t.string :obs_registered_program, limit: 255
      t.timestamps
    end
  end
end
