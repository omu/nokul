# frozen_string_literal: true

require 'test_helper'

class CalendarEventTest < ActiveSupport::TestCase
  include AssociationTestModule
  include ValidationTestModule

  setup do
    @calendar_event = calendar_events(:add_drop_fall_2018_grad)
  end

  # relations
  belongs_to :calendar
  belongs_to :calendar_event_type

  # validations: presence
  validates_presence_of :timezone
  validates_presence_of :calendar_event_type

  # validations: uniqueness
  validates_uniqueness_of :calendar

  # validations: length
  validates_length_of :timezone

  # other validations
  test 'visible field of calendar_event can not be nil' do
    fake = @calendar_event.dup
    fake.visible = nil
    assert_not fake.valid?

    error_codes = fake.errors.details[:visible].map { |err| err[:error] }
    assert error_codes.include?(:inclusion)
  end
end
