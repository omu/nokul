# frozen_string_literal: true

require 'test_helper'

class CalendarTitleTest < ActiveSupport::TestCase
  test 'should not save calendar_title without name' do
    calendar_title = CalendarTitle.new
    assert_not calendar_title.save
  end

  test 'name should be unique' do
    calendar_title = calendar_titles(:one)
    calendar_title.save
    duplicate_calendar_title = calendar_title.dup
    assert_not duplicate_calendar_title.valid?
  end

  test 'should contain types' do
    calendar_title = calendar_titles(:three)
    check_association = calendar_title.types.any? { |t| CalendarType.all.include?(t) }
    assert check_association
  end
end
