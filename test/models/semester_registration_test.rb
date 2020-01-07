# frozen_string_literal: true

require 'test_helper'

class SemesterRegistrationTest < ActiveSupport::TestCase
  extend Support::Minitest::AssociationHelper
  extend Support::Minitest::CallbackHelper
  extend Support::Minitest::EnumerationHelper
  extend Support::Minitest::ValidationHelper

  # callbacks
  before_validation :assign_academic_term_and_semester

  # enums
  enum status: { draft: 0, saved: 1 }

  # relations
  belongs_to :academic_term
  belongs_to :student
  has_many :course_enrollments, dependent: :destroy

  # validations: uniqueness
  test 'uniqueness validations for semester registration of a semester' do
    fake = semester_registrations(:serhat_third_semester).dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:semester]
  end
end
