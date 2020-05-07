# frozen_string_literal: true

require 'test_helper'

class CalendarEventTest < ActiveSupport::TestCase
  extend Support::Minitest::AssociationHelper
  extend Support::Minitest::ValidationHelper

  # relations
  belongs_to :calendar
  belongs_to :calendar_event_type

  # validations: presence
  validates_presence_of :start_time
  validates_presence_of :timezone

  # validations: uniqueness
  validates_uniqueness_of :calendar

  # validations: length
  validates_length_of :timezone

  test 'active_now? method' do
    assert_not calendar_events(:add_drop_fall_2018_grad).active_now?
    assert calendar_events(:mid_term_results_announcement).active_now?
  end
end
