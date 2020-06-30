# frozen_string_literal: true

require 'test_helper'

class EmployeeTest < ActiveSupport::TestCase
  extend Support::Minitest::AssociationHelper
  extend Support::Minitest::ValidationHelper

  # relations
  belongs_to :title
  belongs_to :user
  has_many :administrative_functions, through: :duties
  has_many :available_course_lecturers, foreign_key: :lecturer_id, inverse_of: :lecturer, dependent: :destroy
  has_many :coordinatorships, class_name: 'AvailableCourse', foreign_key: :coordinator_id,
                              inverse_of: :coordinator, dependent: :destroy
  has_many :duties, dependent: :destroy
  has_many :units, through: :duties
  has_many :positions, through: :duties

  # validations: presence
  validates_presence_of :active
  validates_presence_of :staff_number

  # validations: uniqueness
  validates_uniqueness_of :title_id
  validates_uniqueness_of :staff_number

  # delegations
  test 'an employee can reach addresses and identities over user' do
    assert employees(:serhat_active).addresses
    assert employees(:serhat_active).identities
  end

  # scopes
  test 'an employee have defined scopes for active and passive situation' do
    assert users(:serhat).employees.active
    assert users(:serhat).employees.passive
    assert users(:serhat).employees.academic
  end

  # employee validator
  test 'a user can not have more than one active employees' do
    fake = employees(:serhat_active).dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:base]
    assert_includes(fake.errors[:base], t('validators.employee.active'))
  end

  test 'a user can have more than one passive employees' do
    fake = employees(:serhat_passive).dup
    fake.update(title: titles(:chief), staff_number: 'B1500')
    assert fake.valid?
    assert_empty fake.errors[:base]
  end

  # scopes
  test 'active scope returns active employees of user' do
    active = users(:serhat).employees.active
    assert_includes(active.to_a, employees(:serhat_active))
    assert_not active.to_a.include?(employees(:serhat_passive))
  end

  # custom methods
  test 'is an employee title academic' do
    assert employees(:serhat_active).academic?
    assert_not employees(:chief_john).academic?
  end

  test 'given_courses method' do
    given_courses = employees(:serhat_active).given_courses.to_a
    assert_includes given_courses, available_courses(:compulsory_course)
    assert_includes given_courses, available_courses(:elective_course)
    assert_includes given_courses, available_courses(:elective_course_2)
    assert_not_includes given_courses, available_courses(:compulsory_course_2)
  end
end
