# frozen_string_literal: true

require 'test_helper'

class UnitStatusTest < ActiveSupport::TestCase
  include AssociationTestModule
  include ReferenceTestModule

  # relations
  has_many :units, dependent: :nullify
end
