# frozen_string_literal: true

require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  extend Support::Minitest::AssociationHelper
  extend Support::Minitest::CallbackHelper
  extend Support::Minitest::EnumerationHelper
  extend Support::Minitest::ValidationHelper
  include ActiveJob::TestHelper

  # enums
  enum status: {
    active:     1,
    passive:    2,
    disengaged: 3,
    unenrolled: 4,
    graduated:  5
  }

  # relations
  belongs_to :entrance_type, class_name: 'StudentEntranceType'
  belongs_to :registration_term, class_name: 'AcademicTerm', optional: true
  belongs_to :scholarship_type, optional: true
  belongs_to :stage, class_name: 'StudentGrade', optional: true
  belongs_to :user
  belongs_to :unit
  has_one :identity, dependent: :destroy
  has_many :calendars, through: :unit
  has_many :curriculums, through: :unit
  has_many :semester_registrations, dependent: :destroy
  has_many :course_enrollments, through: :semester_registrations

  # validations: presence
  validates_presence_of :other_studentship
  validates_presence_of :permanently_registered
  validates_presence_of :preparatory_class
  validates_presence_of :semester
  validates_presence_of :student_number
  validates_presence_of :year

  # validations: numericality
  validates_numericality_of :preparatory_class
  validates_numerical_range :preparatory_class, greater_than_or_equal_to: 0, less_than_or_equal_to: 2
  validates_numerical_range :semester, greater_than: 0
  validates_numerical_range :year, greater_than_or_equal_to: 0

  # validations: uniqueness
  validates_uniqueness_of :student_number
  validates_uniqueness_of :unit_id

  # callback tests
  after_commit :build_identity_information

  # delegations
  test 'a student can communicate with addresses over the user' do
    assert students(:serhat).addresses
  end

  # scopes
  test 'abroads scope returns students from abroad' do
    assert_includes(Student.abroads, students(:serhat_omu))
  end

  test 'exceeded scope returns students with exceeded education period' do
    assert_includes(Student.exceeded, students(:john))
  end

  test 'not_scholarships scope returns students without scholarship' do
    assert_includes(Student.not_scholarships, students(:john))
  end

  test 'scholarships scope returns students with scholarship' do
    assert_includes(Student.scholarships, students(:serhat))
  end

  test 'preparations scope returns students with preparations' do
    assert_includes(Student.preparations, students(:serhat_omu))
  end

  # custom methods

  test 'abroad?' do
    assert students(:serhat_omu).abroad?
    assert_not students(:mike).abroad?
  end

  test 'gpa method' do
    assert_equal students(:serhat).gpa, 1.8
    assert_equal students(:serhat_omu).gpa, 0
  end

  test 'preparatory_class_repetition? method' do
    assert students(:serhat_omu).preparatory_class_repetition?
    assert_not students(:john).preparatory_class_repetition?
  end

  test 'scholarship?' do
    assert students(:serhat).scholarship?
    assert_not students(:john).scholarship?
  end

  # job tests
  test 'student enqueues Kps::IdentitySaveJob after being created' do
    users(:serhat).students.destroy_all
    assert_enqueued_with(job: Kps::IdentitySaveJob) do
      Student.create(student_number: '1234', user: users(:serhat), unit: units(:omu), year: 1, semester: 1,
                     entrance_type: student_entrance_types(:osys))
    end
  end
end
