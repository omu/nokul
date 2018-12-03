# frozen_string_literal: true

require 'test_helper'

class ExceptForTest < ActiveSupport::TestCase
  setup do
    Unit.send :include, ExceptFor
  end

  test 'except_for method' do
    units = Unit.except_for(units(:omu, :cbu))
    assert_equal (Unit.count - 2), units.count
    assert_not_includes units, units(:omu)
  end
end
