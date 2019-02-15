# frozen_string_literal: true

require 'test_helper'

class MeetingAgendaTest < ActiveSupport::TestCase
  include AssociationTestModule
  include ValidationTestModule

  # relations
  belongs_to :agenda
  belongs_to :committee_meeting
  has_one :decision

  # validations: presence
  validates_presence_of :agenda
  validates_presence_of :sequence_no

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
