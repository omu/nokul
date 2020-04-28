# frozen_string_literal: true

require 'test_helper'

class StudentHistoryTest < ActiveSupport::TestCase
  extend Support::Minitest::AssociationHelper
  extend Support::Minitest::ValidationHelper

  # relations
  belongs_to :student
  belongs_to :entrance_type, class_name: 'StudentEntranceType'
  belongs_to :graduation_term, class_name: 'AcademicTerm'
  belongs_to :registration_term, class_name: 'AcademicTerm'

  # validations: presence
  validates_presence_of :other_studentship
  validates_presence_of :preparatory_class

  # validations: numericality
  validates_numericality_of :preparatory_class
end
