# frozen_string_literal: true

require 'test_helper'

class AssessmentDecoratorTest < ActiveSupport::TestCase
  setup do
    @assessment = AssessmentDecorator.new(course_assessment_methods(:elective_midterm_exam_assessment))
  end

  test 'editable? method' do
    assert @assessment.editable?
  end

  test 'saveable? method' do
    assert_not @assessment.saveable?
  end

  test 'results_announcement_event method' do
    assert @assessment.results_announcement_event
  end
end
