# frozen_string_literal: true

require 'test_helper'

class CourseTypeTest < ActiveSupport::TestCase
  include AssociationTestModule
  include ValidationTestModule

  # relations
  has_many :courses, dependent: :nullify

  # validations: presence
  validates_presence_of :name
  validates_presence_of :code
  validates_presence_of :min_credit

  # validations: uniqueness
  validates_uniqueness_of :name
  validates_uniqueness_of :code

  # validations: length
  validates_length_of :name
  validates_length_of :code

  # validations: numericality
  validates_numerical_range :min_credit, greater_than_or_equal_to: 0
end
