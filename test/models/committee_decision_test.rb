# frozen_string_literal: true

require 'test_helper'

class CommitteeDecisionTest < ActiveSupport::TestCase
  extend Support::Minitest::AssociationHelper
  extend Support::Minitest::CallbackHelper
  extend Support::Minitest::ValidationHelper

  # relations
  belongs_to :meeting_agenda
  has_one :agenda, through: :meeting_agenda
  has_many :calendar_committee_decisions, dependent: :destroy

  # validations: presence
  validates_presence_of :description
  validates_presence_of :decision_no

  # validations: length
  validates_length_of :decision_no
  validates_length_of :description, maximum: 65_535

  # delegates
  %i[
    meeting_agenda_meeting_no
    meeting_agenda_meeting_date
    meeting_agenda_year
    meeting_agenda_unit
  ].each do |property|
    test "a decision reach committee_meeting's #{property} parameter" do
      assert committee_decisions(:one).send(property)
    end
  end

  # callbacks
  before_validation :assign_year_and_decision_no
  after_create :change_status_to_decided

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
    assert_equal 3, committee_decisions(:one).send(:count_of_decisions_by_year, 2018)
  end
end
