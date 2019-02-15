# frozen_string_literal: true

require 'test_helper'

class EmployeeTest < ActiveSupport::TestCase
  include AssociationTestModule
  include ValidationTestModule

  # relations
  belongs_to :user
  belongs_to :title
  has_many :duties
  has_many :units
  has_many :positions
  has_many :administrative_functions
  has_many :available_course_lecturers

  # validations: presence
  validates_presence_of :active

  # validations: uniqueness
  validates_uniqueness_of :title_id

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
    assert fake.errors[:base].include?(t('validators.employee.active'))
  end

  test 'a user can have more than one passive employees' do
    fake = employees(:serhat_passive).dup
    fake.update(title: titles(:chief))
    assert fake.valid?
    assert_empty fake.errors[:base]
  end

  # scopes
  test 'active scope returns active employees of user' do
    active = users(:serhat).employees.active
    assert active.to_a.include?(employees(:serhat_active))
    assert_not active.to_a.include?(employees(:serhat_passive))
  end

  # custom methods
  test 'is an employee title academic' do
    assert employees(:serhat_active).academic?
    assert_not employees(:chief_john).academic?
  end
end
