# frozen_string_literal: true

require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  extend Support::Minitest::AssociationHelper
  extend Support::Minitest::CallbackHelper
  extend Support::Minitest::ValidationHelper
  include ActiveJob::TestHelper

  ECTS = 30

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
  test 'fake gpa method' do
    assert_equal students(:serhat).fake_gpa, 1.8
    assert_equal students(:serhat_omu).fake_gpa, 2.6
  end

  test 'plus ects method' do
    assert_equal students(:serhat).plus_ects, 6
    assert_equal students(:serhat_omu).plus_ects, 10
  end

  test 'semester_enrollments method' do
    course_enrollments = students(:serhat).semester_enrollments
    assert_not_includes course_enrollments, course_enrollments(:old)
    assert_includes course_enrollments, course_enrollments(:elective)
  end

  test 'selected_ects method' do
    assert_equal students(:serhat).selected_ects, selected_ects
  end

  test 'selectable_ects method' do
    assert_equal students(:serhat).selectable_ects, ECTS + students(:serhat).plus_ects - selected_ects
  end

  # job tests
  test 'student enqueues Kps::IdentitySaveJob after being created' do
    users(:serhat).students.destroy_all
    assert_enqueued_with(job: Kps::IdentitySaveJob) do
      Student.create(student_number: '1234', user: users(:serhat), unit: units(:omu), year: 1, semester: 1)
    end
  end

  private

  def selected_ects
    %i[elective compulsory].inject(0) { |ects, enrollment| ects + course_enrollments(enrollment).ects.to_i }
  end
end
