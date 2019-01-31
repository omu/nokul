# frozen_string_literal: true

require 'test_helper'

class CalendarCommitteeDecisionTest < ActiveSupport::TestCase
  # relations
  %i[
    calendar
    committee_decision
  ].each do |property|
    test "a calendar committee decision can communicate with #{property}" do
      assert calendar_committee_decisions(:one).send(property)
    end
  end
end
