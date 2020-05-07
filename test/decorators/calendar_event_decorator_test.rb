# frozen_string_literal: true

require 'test_helper'

class CalendarEventDecoratorTest < ActiveSupport::TestCase
  setup do
    @calendar_event = CalendarEventDecorator.new(calendar_events(:midterm_results_announcement))
  end

  test 'date_range? method' do
    assert_equal @calendar_event.date_range,
                 "#{@calendar_event.start_time&.strftime('%F %R')} - #{@calendar_event.end_time&.strftime('%F %R')}"
  end
end
