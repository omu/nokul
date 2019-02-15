# frozen_string_literal: true

require 'test_helper'

class CommitteeMeetingTest < ActiveSupport::TestCase
  include AssociationTestModule
  include ValidationTestModule

  # relations
  belongs_to :unit
  has_many :meeting_agendas
  has_many :agendas
  has_many :decisions

  # validations: presence
  validates_presence_of :meeting_no
  validates_presence_of :meeting_date

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
