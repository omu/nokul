# frozen_string_literal: true

require 'test_helper'

class StudentDecoratorTest < ActiveSupport::TestCase
  setup do
    @student = StudentDecorator.new(students(:serhat))
  end

  test 'event_online_course_registrations method' do
    assert @student.event_online_course_registrations
  end
end
