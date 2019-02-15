# frozen_string_literal: true

require 'test_helper'

class DocumentTypeTest < ActiveSupport::TestCase
  include AssociationTestModule
  include ValidationTestModule

  setup do
    @document = document_types(:health_report)
  end

  # relations
  has_many :registration_documents

  # validations: presence
  validates_presence_of :name

  # validations: uniqueness
  validates_uniqueness_of :name

  # validations: length
  validates_length_of :name

  test 'active field of document_type can not be nil' do
    fake = @document.dup
    fake.active = nil
    assert_not fake.valid?
    assert fake.errors.details[:active].map { |err| err[:error] }.include?(:inclusion)
  end
end
