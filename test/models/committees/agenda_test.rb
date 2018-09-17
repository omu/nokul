# frozen_string_literal: true

require 'test_helper'

class AgendaTest < ActiveSupport::TestCase
  # relations
  %i[
    unit
    agenda_type
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
end
