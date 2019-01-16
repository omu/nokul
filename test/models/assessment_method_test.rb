# frozen_string_literal: true

require 'test_helper'

class AssessmentMethodTest < ActiveSupport::TestCase
  setup do
    @assessment_method = assessment_methods(:exam)
  end

  # relations
  %i[
    course_assessment_methods
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

  # callbacks
  test 'callbacks must titlecase the name of a assessment method' do
    assessment_method = AssessmentMethod.create!(name: 'test assessment method')
    assert_equal assessment_method.name, 'Test Assessment Method'
  end
end
