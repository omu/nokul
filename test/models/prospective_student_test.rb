# frozen_string_literal: true

require 'test_helper'

class ProspectiveStudentTest < ActiveSupport::TestCase
  include AssociationTestModule
  include EnumerationTestModule
  include ValidationTestModule

  # relations
  belongs_to :student_entrance_type
  belongs_to :unit

  # validations: presence
  validates_presence_of :gender
  validates_presence_of :id_number
  validates_presence_of :first_name
  validates_presence_of :last_name

  # validations: uniqueness
  validates_uniqueness_of :id_number

  # validations: length
  validates_length_of :address
  validates_length_of :email
  validates_length_of :fathers_name
  validates_length_of :first_name
  validates_length_of :high_school_code
  validates_length_of :high_school_branch
  validates_length_of :home_phone
  validates_length_of :last_name
  validates_length_of :mobile_phone
  validates_length_of :mothers_name
  validates_length_of :obs_registered_program
  validates_length_of :place_of_birth
  validates_length_of :placement_score_type
  validates_length_of :registration_city
  validates_length_of :registration_district

  # enums
  has_enum :additional_score, values: { handicapped: 1 }
  has_enum :gender, values: { male: 1, female: 2 }
  has_enum :nationality, values: { turkish: 1, kktc: 2, foreign: 3 }
  has_enum :placement_type, values: { general_score: 1, additional_score: 2 }

  # callbacks
  test 'callbacks must titlecase the name for a prospective_student' do
    prospective_student = prospective_students(:serhat).dup
    prospective_student.update!(
      id_number: '10114899148',
      first_name: 'first name',
      last_name: 'last name',
      fathers_name: 'fathers name',
      mothers_name: 'mothers name',
      place_of_birth: 'place of birth',
      registration_city: 'registration city',
      registration_district: 'registration district'
    )
    assert_equal prospective_student.first_name, 'First Name'
    assert_equal prospective_student.last_name, 'LAST NAME'
    assert_equal prospective_student.fathers_name, 'Fathers Name'
    assert_equal prospective_student.mothers_name, 'Mothers Name'
    assert_equal prospective_student.place_of_birth, 'Place Of Birth'
    assert_equal prospective_student.registration_city, 'Registration City'
    assert_equal prospective_student.registration_district, 'Registration District'
  end

  # search
  test 'prospective_student is a searchable model' do
    assert_not_empty ProspectiveStudent.search('Serhat')
    assert ProspectiveStudent.search('Serhat').include?(prospective_students(:serhat))
    assert_not ProspectiveStudent.search('Serhat').include?(prospective_students(:john))
  end

  # custom tests
  test 'can_permanently_register? returns if can permanently register' do
    assert prospective_students(:serhat).can_permanently_register?
    assert_not prospective_students(:john).can_permanently_register?
  end

  test 'can_temporarily_register? returns if can temporarily register' do
    assert prospective_students(:serhat).can_temporarily_register?
    assert_not prospective_students(:john).can_temporarily_register?
  end
end
