# frozen_string_literal: true

require 'test_helper'

class DocumentTypeTest < ActiveSupport::TestCase
  include AssociationTestModule
  include ValidationTestModule

  # relations
  has_many :registration_documents, dependent: :destroy

  # validations: presence
  validates_presence_of :name
  validates_presence_of :active

  # validations: uniqueness
  validates_uniqueness_of :name

  # validations: length
  validates_length_of :name
end
