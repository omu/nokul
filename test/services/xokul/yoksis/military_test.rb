# frozen_string_literal: true

require 'test_helper'

class MilitaryTest < ActiveSupport::TestCase
  test "trying to get someone's military informations" do
    assert Xokul::Yoksis::Military.informations id_number: ENV['MILITARY_TEST_ID_NUMBER']

    assert_raises Net::HTTPError, Net::HTTPFatalError do
      Xokul::Yoksis::Military.informations id_number: 11_111_111_111
      Xokul::Yoksis::Military.informations id_number: 'id number as string'
    end
  end
end
