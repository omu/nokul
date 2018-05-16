# frozen_string_literal: true

require 'test_helper'

class CalendarTitleTest < ActiveSupport::TestCase
  # presence validation tests
  test 'should not save calendar_title without name' do
    calendar_titles(:one).name = nil
    refute calendar_titles(:one).valid?
  end

  # relational tests
  test 'should contain types' do
    assert calendar_titles(:three).types
  end

  # duplication tests
  test 'name should be unique' do
    refute calendar_titles(:one).dup.valid?
  end
end
