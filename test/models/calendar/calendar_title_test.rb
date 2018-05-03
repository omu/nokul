# frozen_string_literal: true

require 'test_helper'

class CalendarTitleTest < ActiveSupport::TestCase
  test 'should not save calendar_title without name' do
    assert_not CalendarTitle.new.save
  end

  test 'name should be unique' do
    dup_calendar_title = calendar_titles(:one).dup
    assert_not dup_calendar_title.valid?
  end

  test 'should contain types' do
    assert calendar_titles(:three).types
  end
end
