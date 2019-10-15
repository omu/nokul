# frozen_string_literal: true

require 'test_helper'

class ProspectiveStudentTest < ActiveSupport::TestCase
  include ProspectiveTest

  # relations
  belongs_to :academic_term
  belongs_to :high_school_type, optional: true
  belongs_to :language, optional: true
  belongs_to :student_entrance_type
  belongs_to :student_disability_type, optional: true
  belongs_to :user

  # validations: presence
  validates_presence_of :expiry_date

  # validations: length
  validates_length_of :address
  validates_length_of :fathers_name
  validates_length_of :high_school_code
  validates_length_of :high_school_branch
  validates_length_of :home_phone
  validates_length_of :mothers_name
  validates_length_of :obs_registered_program
  validates_length_of :place_of_birth
  validates_length_of :placement_score_type
  validates_length_of :registration_city
  validates_length_of :registration_district

  # enums
  enum additional_score: { handicapped: 1 }
  enum nationality: { turkish: 1, kktc: 2, foreign: 3 }
  enum placement_type: { general_score: 1, additional_score: 2 }
  enum system_register_type: { manual: 0, bulk: 1 }

  # search
  test 'prospective_student is a searchable model' do
    assert_not_empty ProspectiveStudent.search('Serhat')
    assert_includes(ProspectiveStudent.search('Serhat'), prospective_students(:serhat))
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
