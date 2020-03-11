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
    active:       1,
    passive:      2,
    disengaged:   3,
    not_enrolled: 4,
    graduated:    5
  }

  # relations
  belongs_to :scholarship_type, optional: true
  belongs_to :user
  belongs_to :unit
  has_one :identity, dependent: :destroy
  has_many :calendars, through: :unit
  has_many :curriculums, through: :unit
  has_many :semester_registrations, dependent: :destroy
  has_many :course_enrollments, through: :semester_registrations

  # validations: presence
  validates_presence_of :student_number
  validates_presence_of :semester
  validates_presence_of :year

  # validations: numericality
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
  test 'exceeded scope returns students with exceeded education period' do
    assert_includes(Student.exceeded, students(:john))
  end

  test 'not_scholarships scope returns students without scholarship' do
    assert_includes(Student.not_scholarships, students(:john))
  end

  test 'scholarships scope returns students with scholarship' do
    assert_includes(Student.scholarships, students(:serhat))
  end

  # custom methods
  test 'gpa method' do
    assert_equal students(:serhat).gpa, 1.8
    assert_equal students(:serhat_omu).gpa, 0
  end

  test 'scholarship?' do
    assert students(:serhat).scholarship?
    assert_not students(:john).scholarship?
  end

  # job tests
  test 'student enqueues Kps::IdentitySaveJob after being created' do
    users(:serhat).students.destroy_all
    assert_enqueued_with(job: Kps::IdentitySaveJob) do
      Student.create(student_number: '1234', user: users(:serhat), unit: units(:omu), year: 1, semester: 1)
    end
  end
end
