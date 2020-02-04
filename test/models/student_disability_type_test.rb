# frozen_string_literal: true

require 'test_helper'

class StudentDisabilityTypeTest < ActiveSupport::TestCase
  extend Support::Minitest::AssociationHelper
  include ReferenceTestModule

  # relations
  has_many :prospective_students, dependent: :nullify
  has_many :users, foreign_key: :disability_type_id, inverse_of: :disability_type, dependent: :nullify
end
