# frozen_string_literal: true

require 'test_helper'

class MeetingAgendaTest < ActiveSupport::TestCase
  include AssociationTestModule

  # relations
  belongs_to :agenda
  belongs_to :committee_meeting
  has_one :decision

  # validations: presence
  %i[
    agenda
    sequence_no
  ].each do |property|
    test "presence validations for #{property} of a meeting agenda" do
      meeting_agendas(:one).send("#{property}=", nil)
      assert_not meeting_agendas(:one).valid?
      assert_not_empty meeting_agendas(:one).errors[property]
    end
  end

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
