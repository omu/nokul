# frozen_string_literal: true

require 'test_helper'

class StudentEntranceTypeTest < ActiveSupport::TestCase
  extend Nokul::Support::Minitest::AssociationHelper
  include ReferenceTestModule

  # relations
  has_many :prospective_students, dependent: :nullify

  # validations: presence
  validates_presence_of :abroad

  # scopes
  test 'abroads scope returns entrance types with abroad' do
    assert_includes(StudentEntranceType.abroads, student_entrance_types(:aos))
  end
end
