# frozen_string_literal: true

require 'test_helper'

class StudentEntranceTypeTest < ActiveSupport::TestCase
  extend Support::Minitest::AssociationHelper
  include ReferenceTestModule

  # relations
  has_many :prospective_students, dependent: :nullify
end
