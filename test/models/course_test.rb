# frozen_string_literal: true

require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  extend Nokul::Support::Minitest::AssociationHelper
  extend Nokul::Support::Minitest::CallbackHelper
  extend Nokul::Support::Minitest::EnumerationHelper
  extend Nokul::Support::Minitest::ValidationHelper

  # relations
  belongs_to :course_type
  belongs_to :language
  belongs_to :unit
  has_many :curriculum_courses, dependent: :destroy
  has_many :available_courses, through: :curriculum_courses

  # validations: presence
  validates_presence_of :code
  validates_presence_of :laboratory
  validates_presence_of :name
  validates_presence_of :practice
  validates_presence_of :program_type
  validates_presence_of :status
  validates_presence_of :theoric

  # validations: uniqueness
  validates_uniqueness_of :name
  validates_uniqueness_of :code

  # validations: length
  validates_length_of :name
  validates_length_of :code

  # enums
  enum status: { passive: 0, active: 1 }
  enum program_type: { associate: 0, undergraduate: 1, master: 2, doctoral: 3 }

  # callbacks
  before_validation :capitalize_attributes
  before_validation :assign_credit

  test 'callbacks must set value the credit for a course' do
    course = courses(:test).dup
    course.update(code: 'DD101', theoric: 10, practice: 3)
    assert_in_delta(course.credit, 11.5)
  end

  # actions
  test '#calculate_credit' do
    course = courses(:test)
    course.theoric = 8
    course.practice = 3
    course.laboratory = 4
    assert_in_delta(course.calculate_credit, 11.5)
  end
end
