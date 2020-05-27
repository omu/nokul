# frozen_string_literal: true

require 'test_helper'

class AvailableCourseDecoratorTest < ActiveSupport::TestCase
  setup do
    @available_course = AvailableCourseDecorator.new(available_courses(:elective_course))
  end

  test 'manageable? method' do
    assert @available_course.manageable?
  end
end
