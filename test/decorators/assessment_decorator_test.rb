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

  test 'gradable? method' do
    assert @assessment.gradable?
  end

  test 'gradable_date_range method' do
    assert_equal @assessment.gradable_date_range,
                 CalendarEventDecorator.new(calendar_events(:midterm_results_announcement)).date_range
  end
end
