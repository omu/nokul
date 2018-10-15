# frozen_string_literal: true

require 'test_helper'

class GraduatesTest < ActiveSupport::TestCase
  test "trying to get someone's college graduation informations" do
    assert Xokul::Yoksis::Graduates.informations(
      id_number: Rails.application.credentials.yoksis[:graduates_test_id_number]
    )

    assert_raises Net::HTTPError, Net::HTTPFatalError do
      Xokul::Yoksis::Graduates.informations id_number: 11_111_111_111
      Xokul::Yoksis::Graduates.informations id_number: 'id number as string'
    end
  end
end
