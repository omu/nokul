# frozen_string_literal: true

require 'test_helper'

class MeetingAgendaTest < ActiveSupport::TestCase
  extend Support::Minitest::AssociationHelper
  extend Support::Minitest::ValidationHelper

  # relations
  belongs_to :agenda
  belongs_to :committee_meeting
  has_one :decision, dependent: :destroy, class_name: 'CommitteeDecision'

  # validations: presence
  validates_presence_of :sequence_no

  # validations: uniqueness
  validates_uniqueness_of :agenda_id

  # delegates
  %i[
    agenda_type
    description
    status
  ].each do |property|
    test "a meeting agenda reach agenda's #{property} parameter" do
      assert meeting_agendas(:one).send(property)
    end
  end
end
