# frozen_string_literal: true

require 'test_helper'

class CalendarCommitteeDecisionTest < ActiveSupport::TestCase
  include AssociationTestModule

  # relations
  belongs_to :calendar
  belongs_to :committee_decision
end
