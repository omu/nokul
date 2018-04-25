# frozen_string_literal: true

require 'test_helper'

module Calendar
  class CalendarTypeTest < ActiveSupport::TestCase
    test 'should not save calendar_type without name' do
      calendar_type = CalendarType.new
      assert_not calendar_type.save
    end

    test 'name should be unique' do
      calendar_type = CalendarType.new(name: 'Yüksek Lisans')
      calendar_type.save
      duplicate_calendar_type = calendar_type.dup
      assert_not duplicate_calendar_type.valid?
    end
  end
end
