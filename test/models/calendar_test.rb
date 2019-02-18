# frozen_string_literal: true

require 'test_helper'

class CalendarTest < ActiveSupport::TestCase
  include AssociationTestModule
  include ValidationTestModule

  # relations
  belongs_to :academic_term
  has_many :calendar_committee_decisions
  has_many :calendar_events
  has_many :calendar_event_types
  has_many :committee_decisions
  has_many :unit_calendars
  has_many :units

  # validations: presence
  validates_presence_of :name
  validates_presence_of :timezone

  # validations: uniqueness
  validates_uniqueness_of :name

  # validations: length
  validates_length_of :name
  validates_length_of :timezone
  validates_length_of :description, maximum: 65_535

  # validations: nested models
  validates_presence_of_nested_model :committee_decisions
end
