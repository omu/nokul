# frozen_string_literal: true

require 'test_helper'

class CalendarEventTypeTest < ActiveSupport::TestCase
  include AssociationTestModule
  include ValidationTestModule

  setup do
    @calendar_event_type = calendar_event_types(:add_drop_registrations)
  end

  # relations
  has_many :calendars
  has_many :calendar_events

  # validations: presence
  validates_presence_of :name
  validates_presence_of :identifier

  # validations: uniqueness
  validates_uniqueness_of :name
  validates_uniqueness_of :identifier

  # validations: length
  validates_length_of :name
  validates_length_of :identifier
end
