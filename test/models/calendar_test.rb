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

  # validations: length
  validates_length_of :name
  validates_length_of :timezone
  validates_length_of :description, 'text'
end
