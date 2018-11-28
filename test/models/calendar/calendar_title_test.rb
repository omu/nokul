# frozen_string_literal: true

require 'test_helper'

class CalendarTitleTest < ActiveSupport::TestCase
  # relations
  %i[
    types
    calendar_title_types
  ].each do |property|
    test "a calendar title can communicate with #{property}" do
      assert calendar_titles(:three).send(property)
    end
  end

  # validations: presence
  test 'should not save calendar_title without name' do
    calendar_titles(:one).name = nil
    assert_not calendar_titles(:one).valid?
    assert_not_empty calendar_titles(:one).errors[:name]
  end

  # validations: uniqueness
  test 'name should be unique' do
    fake_title = calendar_titles(:one).dup
    assert_not fake_title.valid?
    assert_not_empty fake_title.errors[:name]
  end
end
