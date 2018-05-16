# frozen_string_literal: true

require 'test_helper'

class CalendarTypeTest < ActiveSupport::TestCase
  # presence validation tests
  test 'should not save calendar_type without name' do
    calendar_types(:lisans_önlisans).name = nil
    refute calendar_types(:lisans_önlisans).valid?
  end

  # relational tests
  test 'should contain titles' do
    assert calendar_types(:lisans_önlisans).titles
  end

  # duplication tests
  test 'name should be unique' do
    refute calendar_types(:lisans_önlisans).dup.valid?
  end
end
