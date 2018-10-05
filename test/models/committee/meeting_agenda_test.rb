# frozen_string_literal: true

require 'test_helper'

class MeetingAgendaTest < ActiveSupport::TestCase
  # relations
  %i[
    agenda
    committee_meeting
  ].each do |property|
    test "a meeting agenda can communicate with #{property}" do
      assert meeting_agendas(:one).send(property)
    end
  end

  # validations: presence
  %i[
    agenda_id
    sequence_no
  ].each do |property|
    test "presence validations for #{property} of a meeting agenda" do
      meeting_agendas(:one).send("#{property}=", nil)
      assert_not meeting_agendas(:one).valid?
      assert_not_empty meeting_agendas(:one).errors[property]
    end
  end
end
