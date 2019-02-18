# frozen_string_literal: true

require 'test_helper'

class AdministrativeFunctionTest < ActiveSupport::TestCase
  include AssociationTestModule
  include ReferenceTestModule

  # relations
  has_many :positions, dependent: :destroy
  has_many :duties, through: :positions
end
