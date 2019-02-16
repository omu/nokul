# frozen_string_literal: true

require 'test_helper'

class CommitteeMeetingTest < ActiveSupport::TestCase
  include AssociationTestModule
  include CallbackTestModule
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
  has_validation_callback :assign_year, :before
end
