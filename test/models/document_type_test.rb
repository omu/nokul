# frozen_string_literal: true

require 'test_helper'

class DocumentTypeTest < ActiveSupport::TestCase
  setup do
    @document = document_types(:health_report)
  end

  # relations
  %i[
    registration_documents
  ].each do |property|
    test "a document type can communicate with #{property}" do
      assert @document.send(property)
    end
  end

  # validations: presence
  test 'presence validations for name of a document type' do
    @document.update(name: nil)
    assert_not @document.valid?
    assert_not_empty @document.errors[:name]
  end

  # validations: uniqueness
  test 'uniqueness validations for name of a document type' do
    fake = @document.dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:name]
  end

  # other validations
  test 'name of a document_type can not be longer than 255 characters' do
    fake = @document.dup
    random_long_string = (0...256).map { ('a'..'z').to_a[rand(26)] }.join
    fake.name = random_long_string
    assert_not fake.valid?
    assert fake.errors.details[:name].map { |err| err[:error] }.include?(:too_long)
  end

  test 'active field of document_type can not be nil' do
    fake = @document.dup
    fake.active = nil
    assert_not fake.valid?
    assert fake.errors.details[:active].map { |err| err[:error] }.include?(:inclusion)
  end
end
