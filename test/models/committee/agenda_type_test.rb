# frozen_string_literal: true

require 'test_helper'

class AgendaTypeTest < ActiveSupport::TestCase
  # validations: presence
  test 'should not save agenda_type without name' do
    agenda_types(:one).name = nil
    assert_not agenda_types(:one).valid?
    assert_not_empty agenda_types(:one).errors[:name]
  end
end
