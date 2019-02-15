# frozen_string_literal: true

require 'test_helper'

class CommitteeMeetingTest < ActiveSupport::TestCase
  include AssociationTestModule

  # relations
  belongs_to :unit
  has_many :meeting_agendas
  has_many :agendas
  has_many :decisions

  # validations: presence
  %i[
    meeting_no
    meeting_date
  ].each do |property|
    test "presence validations for #{property} of a committee meeting" do
      committee_meetings(:one).send("#{property}=", nil)
      assert_not committee_meetings(:one).valid?
      assert_not_empty committee_meetings(:one).errors[property]
    end
  end

  # validations: uniqueness
  test 'uniqueness validations for meeting_no of a committee meeting' do
    fake_meeting = committee_meetings(:one).dup
    assert_not fake_meeting.valid?
  end

  # callbacks
  test 'before initialize callback must run for year attribute' do
    meeting = CommitteeMeeting.create(
      meeting_no: 1, meeting_date: Time.current, unit: units(:muhendislik_fakultesi_yonetim_kurulu)
    )
    assert_equal meeting.year, Time.current.year
  end
end
