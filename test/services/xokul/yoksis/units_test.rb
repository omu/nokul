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

  test 'trying to get programs under a department' do
    assert Xokul::Yoksis::Units.programs sub_unit_id: 212_950

    assert_raises Net::HTTPError, Net::HTTPFatalError do
      Xokul::Yoksis::Units.programs sub_unit_id: -1
      Xokul::Yoksis::Units.programs sub_unit_id: 'unit id as string'
    end
  end

  test 'trying to get subunits under a department' do
    assert Xokul::Yoksis::Units.subunits unit_id: 212_950

    assert_raises Net::HTTPError, Net::HTTPFatalError do
      Xokul::Yoksis::Units.subunits unit_id: -1
      Xokul::Yoksis::Units.subunits unit_id: 'unit id as string'
    end
  end

  test 'trying to get units under a university' do
    assert Xokul::Yoksis::Units.unit_name_from_id unit_id: 163_896

    assert_raises Net::HTTPError, Net::HTTPFatalError do
      Xokul::Yoksis::Units.unit_name_from_id unit_id: -1
      Xokul::Yoksis::Units.unit_name_from_id unit_id: 'unit id as string'
    end
  end
end
