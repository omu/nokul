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
