# frozen_string_literal: true

require 'test_helper'

class CalendarEventTypeTest < ActiveSupport::TestCase
  include AssociationTestModule

  setup do
    @calendar_event_type = calendar_event_types(:add_drop_registrations)
  end

  # relations
  has_many :calendars
  has_many :calendar_events

  # validations: presence
  %i[
    name
    identifier
  ].each do |property|
    test "presence validations for #{property} of a calendar event type" do
      @calendar_event_type.send("#{property}=", nil)
      assert_not @calendar_event_type.valid?
      assert_not_empty @calendar_event_type.errors[property]
    end
  end

  # validations: uniqueness
  %i[
    name
    identifier
  ].each do |property|
    test "uniqueness validations for #{property} of a calendar event type" do
      fake = @calendar_event_type.dup
      assert_not fake.valid?
      assert_not_empty fake.errors[property]
    end
  end

  # other validations
  long_string = (0...256).map { ('a'..'z').to_a[rand(26)] }.join

  %i[
    name
    identifier
  ].each do |property|
    test "#{property} of calendar_event_type can not be longer than 255 characters" do
      fake = @calendar_event_type.dup
      fake.send("#{property}=", long_string)
      assert_not fake.valid?
      assert fake.errors.details[property].map { |err| err[:error] }.include?(:too_long)
    end
  end
end
