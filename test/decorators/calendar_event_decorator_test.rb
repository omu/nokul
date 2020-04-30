# frozen_string_literal: true

require 'test_helper'

class CalendarEventDecoratorTest < ActiveSupport::TestCase
  setup do
    @calendar_event = CalendarEventDecorator.new(calendar_events(:mid_term_results_announcement))
  end

  test 'active_now? method' do
    assert_not CalendarEventDecorator.new(calendar_events(:add_drop_fall_2018_grad)).active_now?
    assert @calendar_event.active_now?
  end

  test 'date_range? method' do
    assert_equal @calendar_event.date_range,
                 translate(
                   'date_range',
                   start_time: @calendar_event.start_time&.strftime('%F %R'),
                   end_time:   @calendar_event.end_time&.strftime('%F %R')
                 )
  end

  private

  def translate(key, params = {})
    t("calendar_management.calendars.#{key}", params)
  end
end
