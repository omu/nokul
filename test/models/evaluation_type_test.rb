# frozen_string_literal: true

require 'test_helper'

class EvaluationTypeTest < ActiveSupport::TestCase
  setup do
    @evaluation_type = evaluation_types(:undergraduate_midterm)
  end

  # relations
  %i[
    course_evaluation_types
    available_courses
  ].each do |property|
    test "a evaluation type can communicate with #{property}" do
      assert @evaluation_type.send(property)
    end
  end

  # validations: presence
  test 'presence validations for name of a evaluation type' do
    @evaluation_type.name = nil
    assert_not @evaluation_type.valid?
    assert_not_empty @evaluation_type.errors[:name]
  end

  # callbacks
  test 'callbacks must titlecase the name of a evaluation type' do
    evaluation_type = EvaluationType.create!(name: 'test evaluation type')
    assert_equal evaluation_type.name, 'Test Evaluation Type'
  end
end
