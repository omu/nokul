# frozen_string_literal: true

require 'test_helper'

class CurriculumProgramTest < ActiveSupport::TestCase
  extend Nokul::Support::Minitest::AssociationHelper

  belongs_to :unit
  belongs_to :curriculum
end
