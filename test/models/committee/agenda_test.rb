# frozen_string_literal: true

require 'test_helper'

class AgendaTest < ActiveSupport::TestCase
  # relations
  %i[
    unit
    agenda_type
    meeting_agendas
    meetings
  ].each do |property|
    test "a agenda can communicate with #{property}" do
      assert agendas(:one).send(property)
    end
  end

  # validations: presence
  %i[
    description
    status
  ].each do |property|
    test "presence validations for #{property} of a agenda" do
      agendas(:one).send("#{property}=", nil)
      assert_not agendas(:one).valid?
      assert_not_empty agendas(:one).errors[property]
    end
  end

  # scopes
  test 'active scope returns recent and delayed agendas' do
    assert_equal Agenda.active.count, Agenda.recent.count + Agenda.delayed.count
    assert_not_includes Agenda.active, agendas(:three)
  end
end
