# frozen_string_literal: true

require 'test_helper'

class CalendarEventTest < ActiveSupport::TestCase
  include AssociationTestModule
  include ValidationTestModule

  # relations
  belongs_to :calendar
  belongs_to :calendar_event_type

  # validations: presence
  validates_presence_of :start_time
  validates_presence_of :timezone

  # validations: uniqueness
  validates_uniqueness_of :calendar

  # validations: length
  validates_length_of :timezone
end
