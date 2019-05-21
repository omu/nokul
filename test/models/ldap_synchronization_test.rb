# frozen_string_literal: true

require 'test_helper'

class LdapSynchronizationTest < ActiveSupport::TestCase
  extend Support::Minitest::AssociationHelper
  extend Support::Minitest::EnumerationHelper
  extend Support::Minitest::ValidationHelper

  # enums
  enum status: { start: 0, pending: 1, success: 2, fail: 3 }

  # relations
  belongs_to :user

  # validations: presence
  validates_presence_of :values
end
