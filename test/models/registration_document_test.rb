# frozen_string_literal: true

require 'test_helper'

class RegistrationDocumentTest < ActiveSupport::TestCase
  setup do
    @document = registration_documents(:omu_health_report)
  end

  # relations
  %i[
    unit
    academic_term
    document_type
  ].each do |property|
    test "a registration document can communicate with #{property}" do
      assert @document.send(property)
    end
  end

  # validations: uniqueness
  test 'duplication validations for unit' do
    fake = @document.dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:unit_id]
  end

  # delegations
  test 'a registration document can refer to the name field of related document_type' do
    assert_equal @document.name, @document.document_type.name
  end

  test 'a registration document can refer to the active field of related document_type' do
    assert_equal @document.active, @document.document_type.active
  end
end
