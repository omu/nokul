# frozen_string_literal: true

require 'test_helper'

class ClassroomTest < ActiveSupport::TestCase
  extend Nokul::Support::Minitest::AssociationHelper

  # relations
  belongs_to :place_type
  belongs_to :building
end
