# frozen_string_literal: true

require 'test_helper'

class AgendaTypeTest < ActiveSupport::TestCase
  # relations
  test "a agenda can communicate with agendas" do
    assert agenda_types(:one).agendas
  end

  # validations: presence
  test 'should not save agenda_type without name' do
    agenda_types(:one).name = nil
    assert_not agenda_types(:one).valid?
    assert_not_empty agenda_types(:one).errors[:name]
  end

  # other validations
  long_string = (0...256).map { ('a'..'z').to_a[rand(26)] }.join

  test "name of an agenda type can not be longer than 255 characters" do
    fake = agenda_types(:one).dup
    fake.name = long_string
    assert_not fake.valid?
    assert fake.errors.details[:name].map { |err| err[:error] }.include?(:too_long)
  end

  # callbacks
  test 'callbacks must titlecase the name for an agenda type' do
    agenda_type = agenda_types(:one).dup
    agenda_type.update(name: 'lowercase name')
    assert_equal agenda_type.name, 'Lowercase Name'
  end
end
