# frozen_string_literal: true

require 'test_helper'

class StaffTest < ActiveSupport::TestCase
  test "trying to get an academician's informations" do
    assert Xokul::Yoksis::Staff.academicians id_number: ENV['STAFF_TEST_ID_NUMBER']

    assert_raises Net::HTTPError, Net::HTTPFatalError do
      Xokul::Yoksis::Staff.academicians id_number: 11_111_111_111
      Xokul::Yoksis::Staff.academicians id_number: 'id number as string'
    end
  end

  test 'trying to get nationalities' do
    assert Xokul::Yoksis::Staff.nationalities
  end

  test 'trying to get academician list' do
    assert Xokul::Yoksis::Staff.pages page: 1

    assert_raises Net::HTTPError, Net::HTTPFatalError do
      Xokul::Yoksis::Staff.pages page: -1
      Xokul::Yoksis::Staff.pages page: 'page as string'
    end
  end
end
