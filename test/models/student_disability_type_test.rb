# frozen_string_literal: true

require 'test_helper'

class StudentDisabilityTypeTest < ActiveSupport::TestCase
  extend Nokul::Support::Minitest::AssociationHelper
  include ReferenceTestModule

  # relations
  has_many :prospective_students, dependent: :nullify
end
