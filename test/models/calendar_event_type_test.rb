# frozen_string_literal: true

require 'test_helper'

class CalendarEventTypeTest < ActiveSupport::TestCase
  extend Nokul::Support::Minitest::AssociationHelper
  extend Nokul::Support::Minitest::EnumerationHelper
  extend Nokul::Support::Minitest::ValidationHelper

  # relations
  has_many :calendar_events, dependent: :destroy
  has_many :calendars, through: :calendar_events

  # validations: presence
  validates_presence_of :name
  validates_presence_of :identifier

  # validations: uniqueness
  validates_uniqueness_of :name
  validates_uniqueness_of :identifier

  # validations: length
  validates_length_of :name
  validates_length_of :identifier

  # enums
  enum category: {
    applications:  1,
    payments:      2,
    registrations: 3,
    advisor:       4,
    exams:         5,
    courses:       6,
    submission:    7,
    announcement:  8
  }
end
