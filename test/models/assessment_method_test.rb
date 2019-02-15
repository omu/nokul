# frozen_string_literal: true

require 'test_helper'

class AssessmentMethodTest < ActiveSupport::TestCase
  include AssociationTestModule
  include ValidationTestModule

  setup do
    @assessment_method = assessment_methods(:exam)
  end

  # relations
  has_many :available_courses
  has_many :course_assessment_methods
  has_many :course_evaluation_types

  # validations: presence
  test 'presence validations for name of a assessment method' do
    @assessment_method.name = nil
    assert_not @assessment_method.valid?
    assert_not_empty @assessment_method.errors[:name]
  end

  # other validations
  test 'name can not be longer than 255 characters' do
    fake = @assessment_method.dup
    fake.name = (0...256).map { ('a'..'z').to_a[rand(26)] }.join
    assert_not fake.valid?
    assert fake.errors.details[:name].map { |err| err[:error] }.include?(:too_long)
  end

  # callbacks
  test 'callbacks must titlecase the name of a assessment method' do
    assessment_method = AssessmentMethod.create!(name: 'test assessment method')
    assert_equal assessment_method.name, 'Test Assessment Method'
  end
end
