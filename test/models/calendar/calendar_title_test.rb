# frozen_string_literal: true

require 'test_helper'

class CalendarTitleTest < ActiveSupport::TestCase
  test 'should not save calendar_title without name' do
    calendar_title = CalendarTitle.new
    assert_not calendar_title.save
  end

  test 'name should be unique' do
    calendar_title = CalendarTitle.new(name: 'Ders Kayıtları')
    calendar_title.save
    duplicate_calendar_title = calendar_title.dup
    assert_not duplicate_calendar_title.valid?
  end
end
