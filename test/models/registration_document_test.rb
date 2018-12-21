# frozen_string_literal: true

require 'test_helper'

class RegistrationDocumentTest < ActiveSupport::TestCase
  # relations
  %i[
    unit
    academic_term
    document
  ].each do |property|
    test "a registration document can communicate with #{property}" do
      assert registration_documents(:omu_health_report).send(property)
    end
  end

  # validations: uniqueness
  test 'duplication validations for unit' do
    fake = registration_documents(:omu_health_report).dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:unit]
  end
end
