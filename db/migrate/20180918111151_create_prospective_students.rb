# frozen_string_literal: true

class CreateProspectiveStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :prospective_students do |t|
      t.string :id_number
      t.string :first_name
      t.string :last_name
      t.string :fathers_name
      t.string :mothers_name
      t.date :date_of_birth
      t.integer :gender
      t.integer :nationality
      t.string :place_of_birth
      t.string :registration_city
      t.string :registration_district
      t.string :high_school_code
      t.string :high_school_branch
      t.integer :state_of_education
      t.integer :high_school_graduation_year
      t.integer :placement_type
      t.float :exam_score
      t.string :address
      t.string :home_phone
      t.string :mobile_phone
      t.string :email
      t.boolean :top_student, default: false
      t.float :placement_score
      t.integer :placement_rank
      t.integer :preference_order
      t.string :placement_score_type
      t.integer :additional_score
      t.boolean :meb_status, default: false
      t.datetime :meb_status_date
      t.boolean :military_status, default: false
      t.datetime :military_status_date
      t.boolean :obs_status, default: false
      t.datetime :obs_status_date
      t.string :obs_registered_program
      t.boolean :registered, default: false
      t.references :high_school_type,
                   foreign_key: true
      t.references :language,
                   foreign_key: true
      t.references :student_disability_type,
                   foreign_key: true
      t.references :unit,
                   null: false,
                   foreign_key: true
      t.references :student_entrance_type,
                   null: false,
                   foreign_key: true
      t.timestamps
    end

    add_length_constraint :prospective_students, :id_number, equal_to: 11
    add_length_constraint :prospective_students, :first_name, less_than_or_equal_to: 255
    add_length_constraint :prospective_students, :last_name, less_than_or_equal_to: 255
    add_length_constraint :prospective_students, :fathers_name, less_than_or_equal_to: 255
    add_length_constraint :prospective_students, :mothers_name, less_than_or_equal_to: 255
    add_length_constraint :prospective_students, :place_of_birth, less_than_or_equal_to: 255
    add_length_constraint :prospective_students, :registration_city, less_than_or_equal_to: 255
    add_length_constraint :prospective_students, :registration_district, less_than_or_equal_to: 255
    add_length_constraint :prospective_students, :high_school_code, less_than_or_equal_to: 255
    add_length_constraint :prospective_students, :high_school_branch, less_than_or_equal_to: 255
    add_length_constraint :prospective_students, :address, less_than_or_equal_to: 255
    add_length_constraint :prospective_students, :home_phone, less_than_or_equal_to: 255
    add_length_constraint :prospective_students, :mobile_phone, less_than_or_equal_to: 255
    add_length_constraint :prospective_students, :email, less_than_or_equal_to: 255
    add_length_constraint :prospective_students, :placement_score_type, less_than_or_equal_to: 255
    add_length_constraint :prospective_students, :obs_registered_program, less_than_or_equal_to: 255

    add_presence_constraint :prospective_students, :id_number
    add_presence_constraint :prospective_students, :first_name
    add_presence_constraint :prospective_students, :last_name
    add_presence_constraint :prospective_students, :top_student
    add_presence_constraint :prospective_students, :meb_status
    add_presence_constraint :prospective_students, :military_status
    add_presence_constraint :prospective_students, :obs_status

    add_numericality_constraint :prospective_students, :gender,
                                                    greater_than_or_equal_to: 0
    add_numericality_constraint :prospective_students, :nationality,
                                                    greater_than_or_equal_to: 0
    add_numericality_constraint :prospective_students, :state_of_education,
                                                    greater_than_or_equal_to: 0
    add_numericality_constraint :prospective_students, :high_school_graduation_year,
                                                       greater_than_or_equal_to: 1910,
                                                       less_than_or_equal_to: 2050
    add_numericality_constraint :prospective_students, :placement_type,
                                                       greater_than_or_equal_to: 0
    add_numericality_constraint :prospective_students, :placement_rank,
                                                       greater_than_or_equal_to: 0
    add_numericality_constraint :prospective_students, :preference_order,
                                                       greater_than_or_equal_to: 0
    add_numericality_constraint :prospective_students, :placement_score_type,
                                                       greater_than_or_equal_to: 0
    add_numericality_constraint :prospective_students, :additional_score,
                                                       greater_than_or_equal_to: 0
  end
end
