# frozen_string_literal: true

require 'test_helper'

class CommitteeMeetingTest < ActiveSupport::TestCase
  extend Nokul::Support::Minitest::AssociationHelper
  extend Nokul::Support::Minitest::CallbackHelper
  extend Nokul::Support::Minitest::ValidationHelper

  # relations
  belongs_to :unit
  has_many :meeting_agendas, dependent: :destroy
  has_many :agendas, through: :meeting_agendas
  has_many :decisions, through: :meeting_agendas, class_name: 'CommitteeDecision'
  accepts_nested_attributes_for :meeting_agendas, allow_destroy: true

  # validations: presence
  validates_presence_of :meeting_date
  validates_presence_of :meeting_no

  # validations: uniqueness
  validates_uniqueness_of :meeting_no

  # callbacks
  before_validation :assign_year
end
