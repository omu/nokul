# frozen_string_literal: true

require 'test_helper'

class GraduatesTest < ActiveSupport::TestCase
  test "try getting someone's colleague graduation informations" do
    assert Xokul::Yoksis::Graduates.informations id_number: ENV['GRADUATES_TEST_ID_NUMBER']

    assert_raises Net::HTTPError, Net::HTTPFatalError do
      Xokul::Yoksis::Graduates.informations id_number: 11_111_111_111
    end
  end
end
