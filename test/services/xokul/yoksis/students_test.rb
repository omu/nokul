# frozen_string_literal: true

require 'test_helper'

class StudentsTest < ActiveSupport::TestCase
  test "trying to get a student's informations" do
    assert Xokul::Yoksis::Students.informations(
      id_number: Rails.application.credentials.yoksis[:students_test_id_number]
    )

    assert_raises Net::HTTPError, Net::HTTPFatalError do
      Xokul::Yoksis::Students.informations id_number: 11_111_111_111
      Xokul::Yoksis::Students.informations id_number: 'id number as string'
    end
  end
end
