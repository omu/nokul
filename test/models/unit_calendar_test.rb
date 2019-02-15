# frozen_string_literal: true

require 'test_helper'

class UnitCalendarTest < ActiveSupport::TestCase
  include AssociationTestModule

  # relations
  belongs_to :calendar
  belongs_to :unit
end
