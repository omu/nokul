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

  # validations: presence
  validates_presence_of :student_number
  validates_presence_of :permanently_registered

  # validations: uniqueness
  validates_uniqueness_of :student_number
  validates_uniqueness_of :unit_id

  # callback tests
  after_commit :build_identity_information

  # delegations
  test 'a student can communicate with addresses over the user' do
    assert students(:serhat).addresses
  end

  # job tests
  test 'student enqueues Kps::IdentitySaveJob after being created' do
    users(:serhat).students.destroy_all
    assert_enqueued_with(job: Kps::IdentitySaveJob) do
      Student.create(student_number: '1234', user: users(:serhat), unit: units(:omu))
    end
  end
end
