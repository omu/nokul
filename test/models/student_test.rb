# frozen_string_literal: true

require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  include AssociationTestModule
  include ValidationTestModule
  include ActiveJob::TestHelper

  # relations
  belongs_to :user
  belongs_to :unit
  has_one :identity
  has_many :calendars

  # validations: presence
  validates_presence_of :student_number

  # validations: uniqueness
  test 'a student can not have a duplicate unit and a duplicate student number' do
    fake = students(:serhat).dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:student_number]
    assert_not_empty fake.errors[:unit_id]
  end

  # delegations
  test 'a student can communicate with addresses over the user' do
    assert students(:serhat).addresses
  end

  # callback tests
  test 'student runs Kps::IdentitySaveJob after being created' do
    users(:serhat).students.destroy_all
    assert_enqueued_with(job: Kps::IdentitySaveJob) do
      Student.create(student_number: '1234', user: users(:serhat), unit: units(:omu))
    end
  end
end
