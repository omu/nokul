# frozen_string_literal: true

require 'test_helper'

class CalendarTest < ActiveSupport::TestCase
  extend Support::Minitest::AssociationHelper
  extend Support::Minitest::ValidationHelper

  # relations
  belongs_to :academic_term
  has_many :calendar_committee_decisions, dependent: :destroy
  has_many :calendar_events, dependent: :destroy
  has_many :calendar_event_types, through: :calendar_events
  has_many :committee_decisions, through: :calendar_committee_decisions
  has_many :unit_calendars, dependent: :destroy
  has_many :units, through: :unit_calendars
  accepts_nested_attributes_for :units, allow_destroy: true
  accepts_nested_attributes_for :calendar_events, allow_destroy: true

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
