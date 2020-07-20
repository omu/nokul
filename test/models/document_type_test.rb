# frozen_string_literal: true

require 'test_helper'

class DocumentTypeTest < ActiveSupport::TestCase
  extend Nokul::Support::Minitest::AssociationHelper
  extend Nokul::Support::Minitest::ValidationHelper

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
