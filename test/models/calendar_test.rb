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
  validates_presence_of :name
  validates_presence_of :timezone

  {
    committee_decision_ids: :committee_decisions
  }.each do |property, error_message_key|
    test "presence validations for #{property} of a calendar" do
      @calendar.send("#{property}=", nil)
      assert_not @calendar.valid?
      assert_not_empty @calendar.errors[error_message_key]
    end
  end

  # validations: uniqueness
  validates_uniqueness_of :name

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
