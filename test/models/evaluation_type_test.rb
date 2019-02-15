# frozen_string_literal: true

require 'test_helper'

class EvaluationTypeTest < ActiveSupport::TestCase
  include AssociationTestModule
  include ValidationTestModule

  # relations
  has_many :available_courses
  has_many :course_evaluation_types

  # validations: presence
  validates_presence_of :name

  # validations: uniqueness
  validates_uniqueness_of :name

  # validations: length
  validates_length_of :name

  # callbacks
  test 'callbacks must titlecase the name of a evaluation type' do
    evaluation_type = EvaluationType.create!(name: 'test evaluation type')
    assert_equal evaluation_type.name, 'Test Evaluation Type'
  end
end
