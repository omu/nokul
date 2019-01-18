# frozen_string_literal: true

require 'test_helper'

class AssessmentMethodTest < ActiveSupport::TestCase
  setup do
    @assessment_method = assessment_methods(:exam)
  end

  # relations
  %i[
    course_assessment_methods
    course_evaluation_types
    available_courses
  ].each do |property|
    test "a assessment method can communicate with #{property}" do
      assert @assessment_method.send(property)
    end
  end

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
