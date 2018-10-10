# frozen_string_literal: true

require 'test_helper'

class UnitsTest < ActiveSupport::TestCase
  test 'trying to get changes in a unit' do
    assert Xokul::Yoksis::Units.changes day: 1, month: 12, year: 2017

    assert_raises Net::HTTPError, Net::HTTPFatalError do
      Xokul::Yoksis::Units.changes day: 33, month: 33, year: 3333
      Xokul::Yoksis::Units.changes day: 'str', month: 'str', year: 'str'
    end
  end

  test 'trying to get universities' do
    assert Xokul::Yoksis::Units.universities
  end

  %i[
    programs
    subunits
  ].each do |method|
    test "trying to get #{method} under a department" do
      assert Xokul::Yoksis::Units.send method, unit_id: ENV['DEPARTMENT_TEST_UNIT_ID']

      assert_raises Net::HTTPError, Net::HTTPFatalError do
        Xokul::Yoksis::Units.send method, unit_id: -1
        Xokul::Yoksis::Units.send method, unit_id: 'unit id as string'
      end
    end
  end

  test 'trying to get units under a university' do
    assert Xokul::Yoksis::Units.units unit_id: ENV['UNIVERSITY_TEST_UNIT_ID']

    assert_raises Net::HTTPError, Net::HTTPFatalError do
      Xokul::Yoksis::Units.units unit_id: -1
      Xokul::Yoksis::Units.units unit_id: 'unit id as string'
    end
  end
end
