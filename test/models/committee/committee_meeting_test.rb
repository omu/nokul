# frozen_string_literal: true

require 'test_helper'

class CommitteeMeetingTest < ActiveSupport::TestCase
  # validations: presence
  %i[
    meeting_no
    meeting_date
    year
  ].each do |property|
    test "presence validations for #{property} of a committee meeting" do
      committee_meetings(:one).send("#{property}=", nil)
      assert_not committee_meetings(:one).valid?
      assert_not_empty committee_meetings(:one).errors[property]
    end
  end

  # callbacks
  test 'before initialize callback must run for year attribute' do
    meeting = CommitteeMeeting.create(meeting_no: 1, meeting_date: Time.now, unit: Unit.last)
    assert_equal meeting.year, Time.now.year
  end
end
