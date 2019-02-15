# frozen_string_literal: true

require 'test_helper'

class CalendarTest < ActiveSupport::TestCase
  include AssociationTestModule
  include ValidationTestModule

  setup do
    @calendar = calendars(:uzem_calendar)
  end

  # relations
  belongs_to :academic_term
  has_many :calendar_events
  has_many :calendar_event_types
  has_many :calendar_committee_decisions
  has_many :unit_calendars
  has_many :units

  # validations: presence
  {
    committee_decision_ids: :committee_decisions,
    name: :name,
    timezone: :timezone
  }.each do |property, error_message_key|
    test "presence validations for #{property} of a calendar" do
      @calendar.send("#{property}=", nil)
      assert_not @calendar.valid?
      assert_not_empty @calendar.errors[error_message_key]
    end
  end

  # validations: uniqueness
  %i[
    name
  ].each do |property|
    test "uniqueness validations for #{property} of a calendar" do
      fake = @calendar.dup
      assert_not fake.valid?
      assert_not_empty fake.errors[property]
    end
  end

  # other validations
  long_string = (0...256).map { ('a'..'z').to_a[rand(26)] }.join

  %i[
    name
    timezone
  ].each do |property|
    test "#{property} of calendar can not be longer than 255 characters" do
      fake = @calendar.dup
      fake.send("#{property}=", long_string)
      assert_not fake.valid?
      assert fake.errors.details[property].map { |err| err[:error] }.include?(:too_long)
    end
  end
end
