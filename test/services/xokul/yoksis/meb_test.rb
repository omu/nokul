# frozen_string_literal: true

require 'test_helper'

class MebTest < ActiveSupport::TestCase
  test "trying to get someone's student informations from MEB" do
    assert Xokul::Yoksis::Meb.students id_number: ENV['MEB_TEST_ID_NUMBER']

    assert_raises Net::HTTPError, Net::HTTPFatalError do
      Xokul::Yoksis::Meb.students id_number: 11_111_111_111
      Xokul::Yoksis::Meb.students id_number: 'id number as string'
    end
  end
end
