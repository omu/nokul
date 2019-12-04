# frozen_string_literal: true

require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  extend Support::Minitest::AssociationHelper
  extend Support::Minitest::CallbackHelper
  extend Support::Minitest::ValidationHelper
  include ActiveJob::TestHelper

  # relations
  belongs_to :user
  belongs_to :unit
  has_one :identity, dependent: :destroy
  has_many :calendars, through: :unit
  has_many :curriculums, through: :unit
  has_many :course_enrollments, dependent: :destroy

  # validations: presence
  validates_presence_of :student_number
  validates_presence_of :permanently_registered
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

  # custom methods
  test 'gpa method' do
    assert_equal students(:serhat).gpa, 1.8
    assert_equal students(:serhat_omu).gpa, 0
  end

  # job tests
  test 'student enqueues Kps::IdentitySaveJob after being created' do
    users(:serhat).students.destroy_all
    assert_enqueued_with(job: Kps::IdentitySaveJob) do
      Student.create(student_number: '1234', user: users(:serhat), unit: units(:omu), year: 1, semester: 1)
    end
  end
end
