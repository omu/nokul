# frozen_string_literal: true

require 'test_helper'

class StudentsTest < ActiveSupport::TestCase
  test "trying to get a student's informations" do
    assert Xokul::Yoksis::Students.informations id_number: ENV['STUDENTS_TEST_ID_NUMBER']

    assert_raises Net::HTTPError, Net::HTTPFatalError do
      Xokul::Yoksis::Students.informations id_number: 11_111_111_111
      Xokul::Yoksis::Students.informations id_number: 'id number as string'
    end
  end
end
