# frozen_string_literal: true

require 'test_helper'

class UnitTuitionTest < ActiveSupport::TestCase
  extend Support::Minitest::AssociationHelper
  extend Support::Minitest::ValidationHelper

  # relations
  belongs_to :unit
  belongs_to :tuition
end
