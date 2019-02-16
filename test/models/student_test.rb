# frozen_string_literal: true

require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  include AssociationTestModule
  include CallbackTestModule
  include ValidationTestModule
  include ActiveJob::TestHelper

  # relations
  belongs_to :user
  belongs_to :unit
  has_one :identity
  has_many :calendars

  # validations: presence
  validates_presence_of :student_number
  validates_presence_of :permanently_registered

  # validations: uniqueness
  validates_uniqueness_of :student_number
  validates_uniqueness_of :unit_id

  # delegations
  test 'a student can communicate with addresses over the user' do
    assert students(:serhat).addresses
  end

  # callback tests
  has_commit_callback :build_identity_information, :after

  # job tests
  test 'student enqueues Kps::IdentitySaveJob after being created' do
    users(:serhat).students.destroy_all
    assert_enqueued_with(job: Kps::IdentitySaveJob) do
      Student.create(student_number: '1234', user: users(:serhat), unit: units(:omu))
    end
  end
end
