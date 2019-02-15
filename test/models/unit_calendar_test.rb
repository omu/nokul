# frozen_string_literal: true

require 'test_helper'

class UnitCalendarTest < ActiveSupport::TestCase
  include AssociationTestModule
  include ValidationTestModule

  # relations
  belongs_to :calendar
  belongs_to :unit

  # validations: presence
  validates_presence_of :calendar

  # validations: uniqueness
  validates_uniqueness_of :calendar
end
