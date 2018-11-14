# frozen_string_literal: true

require 'test_helper'

class AvailableCourseTest < ActiveSupport::TestCase
  # relations
  %i[
    academic_term
    curriculum
    course
    groups
  ].each do |property|
    test "a available_course can communicate with #{property}" do
      assert available_courses(:ati_fall_2017_2018).send(property)
    end
  end
end
