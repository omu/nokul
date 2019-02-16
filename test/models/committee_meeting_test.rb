# frozen_string_literal: true

require 'test_helper'

class CommitteeMeetingTest < ActiveSupport::TestCase
  include AssociationTestModule
  include ValidationTestModule

  # relations
  belongs_to :unit
  has_many :agendas
  has_many :decisions
  has_many :meeting_agendas

  # validations: presence
  validates_presence_of :meeting_date
  validates_presence_of :meeting_no

  # validations: uniqueness
  validates_uniqueness_of :meeting_no

  # callbacks
  test 'before initialize callback must run for year attribute' do
    meeting = CommitteeMeeting.create(
      meeting_no: 1, meeting_date: Time.current, unit: units(:muhendislik_fakultesi_yonetim_kurulu)
    )
    assert_equal meeting.year, Time.current.year
  end
end
