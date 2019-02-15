# frozen_string_literal: true

require 'test_helper'

class ProspectiveStudentTest < ActiveSupport::TestCase
  include AssociationTestModule
  include ValidationTestModule

  # relations
  belongs_to :unit
  belongs_to :student_entrance_type

  # validations: presence
  validates_presence_of :id_number
  validates_presence_of :gender

  # validations: uniqueness
  %i[
    id_number
    unit_id
    exam_score
  ].each do |property|
    test "uniqueness validations for #{property} of a prospective_student" do
      fake = prospective_students(:serhat).dup
      assert_not fake.valid?
    end
  end

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
