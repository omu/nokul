# frozen_string_literal: true

require 'test_helper'

class StudentDecoratorTest < ActiveSupport::TestCase
  setup do
    @student = StudentDecorator.new(students(:serhat))
  end

  test 'registrable_for_online_course? method' do
    assert @student.registrable_for_online_course?
  end

  test 'registrable_for_online_course_date_range method' do
    assert_equal @student.registrable_for_online_course_date_range,
                 CalendarEventDecorator.new(calendar_events(:midterm_results_announcement)).date_range
  end
end
