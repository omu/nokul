# frozen_string_literal: true

require 'test_helper'

class CalendarCommitteeDecisionTest < ActiveSupport::TestCase
  extend Nokul::Support::Minitest::AssociationHelper
  extend Nokul::Support::Minitest::ValidationHelper

  # relations
  belongs_to :calendar
  belongs_to :committee_decision

  # validations
  validates_uniqueness_of :calendar
end
