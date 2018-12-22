# frozen_string_literal: true

require 'test_helper'

class CalendarTitleTest < ActiveSupport::TestCase
  setup do
    @title = calendar_titles(:one)
  end

  # relations
  %i[
    types
    calendar_title_types
    calendar_events
  ].each do |property|
    test "a calendar title can communicate with #{property}" do
      assert @title.send(property)
    end
  end

  # validations: presence
  %i[
    name
    identifier
  ].each do |property|
    test "presence validations for #{property} of a calendar title" do
      @title.send("#{property}=", nil)
      assert_not @title.valid?
      assert_not_empty @title.errors[property]
    end
  end

  # validations: uniqueness
  test 'name should be unique' do
    fake = @title.dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:name]
  end

  test 'identifier should be unique' do
    fake = @title.dup
    fake.name = 'fake title'
    assert_not fake.valid?
    assert_not_empty fake.errors[:identifier]
  end
end
