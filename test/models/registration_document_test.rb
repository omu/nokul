# frozen_string_literal: true

require 'test_helper'

class RegistrationDocumentTest < ActiveSupport::TestCase
  include AssociationTestModule
  include ValidationTestModule

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
  validates_length_of :description, type: :text

  # delegations
  test 'a registration document can refer to the name field of related document_type' do
    assert_equal @document.name, @document.document_type.name
  end

  test 'a registration document can refer to the active field of related document_type' do
    assert_equal @document.active, @document.document_type.active
  end
end
