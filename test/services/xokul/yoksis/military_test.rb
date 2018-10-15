# frozen_string_literal: true

require 'test_helper'

class MilitaryTest < ActiveSupport::TestCase
  test "trying to get someone's military informations" do
    assert Xokul::Yoksis::Military.informations(
      id_number: Rails.application.credentials.yoksis[:military_test_id_number]
    )

    assert_raises Net::HTTPError, Net::HTTPFatalError do
      Xokul::Yoksis::Military.informations id_number: 11_111_111_111
      Xokul::Yoksis::Military.informations id_number: 'id number as string'
    end
  end
end
