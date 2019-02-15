# frozen_string_literal: true

require 'test_helper'

class AssessmentMethodTest < ActiveSupport::TestCase
  include AssociationTestModule
  include ValidationTestModule

  # relations
  has_many :available_courses
  has_many :course_assessment_methods
  has_many :course_evaluation_types

  # validations: presence
  validates_presence_of :name

  # validations: uniqueness
  validates_uniqueness_of :name

  # validations: length
  validates_length_of :name

  # callbacks
  test 'callbacks must titlecase the name of a assessment method' do
    assessment_method = AssessmentMethod.create!(name: 'test assessment method')
    assert_equal assessment_method.name, 'Test Assessment Method'
  end
end
