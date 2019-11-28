# frozen_string_literal: true

require 'test_helper'

class StudentDecoratorTest < ActiveSupport::TestCase
  setup do
    @student = StudentDecorator.new(students(:serhat))
  end

  test 'registrable_for_online_course? method' do
    assert_not StudentDecorator.new(students(:serhat_omu)).registrable_for_online_course?
    assert StudentDecorator.new(@student).registrable_for_online_course?
  end

  test 'registation_date_range method' do
    event = calendar_events(:active_online_course_registrations)
    assert_equal StudentDecorator.new(@student).registation_date_range,
                 translate(
                   'index.registration_date_range',
                   start_time: event.start_time&.strftime('%F %R'),
                   end_time:   event.end_time&.strftime('%F %R')
                 )
  end

  private

  def translate(key, params = {})
    t("studentship.course_enrollments.#{key}", params)
  end
end
