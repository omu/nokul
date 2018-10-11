# frozen_string_literal: true

require 'test_helper'

class DecisionTest < ActiveSupport::TestCase
  setup do
    @decision = committee_decisions(:one)
  end

  # relations
  test 'decision can communicate with meeting_agenda' do
    assert @decision.meeting_agenda
  end

  # validations: presence
  %i[
    description
  ].each do |property|
    test "presence validations for #{property} of a decision" do
      @decision.send("#{property}=", nil)
      assert_not @decision.valid?
      assert_not_empty @decision.errors[property]
    end
  end

  # delegates
  %i[
    meeting_agenda_meeting_no
    meeting_agenda_meeting_date
    meeting_agenda_year
    meeting_agenda_unit
  ].each do |property|
    test "a decision reach committee_meeting's #{property} parameter" do
      assert @decision.send(property)
    end
  end

  # callbacks
  test 'before initialize callback must run for year and decision_no attribute' do
    decision = CommitteeDecision.create(description: 'Test Karar', meeting_agenda: meeting_agendas(:one))
    assert_equal 2018, decision.year
    assert_equal '2018/4', decision.decision_no
  end

  # custom
  test 'count_of_decisions_by_year return decision count by year' do
    assert_equal 3, @decision.send(:count_of_decisions_by_year, 2018)
  end
end
