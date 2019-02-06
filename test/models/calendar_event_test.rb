# frozen_string_literal: true

require 'test_helper'

class CalendarEventTest < ActiveSupport::TestCase
  setup do
    @calendar_event = calendar_events(:add_drop_fall_2018_grad)
  end

  # relations
  %i[
    calendar
    calendar_event_type
  ].each do |property|
    test "calendar_event can communicate with #{property}" do
      assert @calendar_event.send(property)
    end
  end

  # validations: presence
  %i[
    timezone
    calendar_event_type
  ].each do |property|
    test "presence validations for #{property} of a calendar event" do
      @calendar_event.send("#{property}=", nil)
      assert_not @calendar_event.valid?
      assert_not_empty @calendar_event.errors[property]
    end
  end

  # validations: uniqueness
  %i[
    calendar
  ].each do |property|
    test "uniqueness validations for #{property} of a calendar event" do
      fake = @calendar_event.dup
      assert_not fake.valid?
      assert_not_empty fake.errors[property]
    end
  end

  # other validations
  test 'visible field of calendar_event can not be nil' do
    fake = @calendar_event.dup
    fake.visible = nil
    assert_not fake.valid?

    error_codes = fake.errors.details[:visible].map { |err| err[:error] }
    assert error_codes.include?(:inclusion)
  end

  test 'active_now can detect if an event is active at the moment' do
    assert calendar_events(:active_calendar_event).active_now?
  end
end
