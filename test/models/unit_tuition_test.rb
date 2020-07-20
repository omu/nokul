# frozen_string_literal: true

require 'test_helper'

class UnitTuitionTest < ActiveSupport::TestCase
  extend Nokul::Support::Minitest::AssociationHelper
  extend Nokul::Support::Minitest::ValidationHelper

  # relations
  belongs_to :unit
  belongs_to :tuition
end
