# frozen_string_literal: true

require 'test_helper'

class RegistrationDocumentTest < ActiveSupport::TestCase
  extend Support::Minitest::AssociationHelper
  extend Support::Minitest::ValidationHelper

  setup do
    @document = registration_documents(:omu_health_report)
  end

  # relations
  belongs_to :academic_term
  belongs_to :document_type
  belongs_to :unit

  # validations: uniqueness
  validates_uniqueness_of :unit_id

  # validations: length
  validates_length_of :description, maximum: 65_535

  # delegations
  test 'a registration document can refer to the name field of related document_type' do
    assert_equal @document.name, @document.document_type.name
  end

  test 'a registration document can refer to the active field of related document_type' do
    assert_equal @document.active, @document.document_type.active
  end
end
