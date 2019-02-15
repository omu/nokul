# frozen_string_literal: true

require 'test_helper'

class CommitteeDecisionTest < ActiveSupport::TestCase
  include AssociationTestModule
  include ValidationTestModule

  setup do
    @decision = committee_decisions(:one)
  end

  # relations
  belongs_to :meeting_agenda
  has_one :agenda
  has_many :calendar_committee_decisions

  # validations: presence
  validates_presence_of :description
  validates_presence_of :decision_no

  # validations: length
  validates_length_of :decision_no
  validates_length_of :description, 'text'

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

  test 'agenda status must update after decision is created' do
    decision = CommitteeDecision.create(description: 'Test Karar', meeting_agenda: meeting_agendas(:four))
    assert_equal 'decided', decision.agenda.status
  end

  # custom
  test 'count_of_decisions_by_year return decision count by year' do
    assert_equal 3, @decision.send(:count_of_decisions_by_year, 2018)
  end
end
