# frozen_string_literal: true

require 'test_helper'

class UniversityTypeTest < ActiveSupport::TestCase
  include ReferenceCallbacksTest
  include ReferenceValidationsTest

  setup do
    @object = university_types(:foundation)
  end

  # relational tests
  test 'university_type can communicate with units' do
    assert @object.units
  end

  # nullify tests
  test 'university_type nullifies the related foreign key from unit when it gets deleted' do
    @object.destroy
    assert_nil units(:cbu).university_type
  end
end
