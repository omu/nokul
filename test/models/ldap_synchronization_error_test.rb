# frozen_string_literal: true

require 'test_helper'

class LdapSynchronizationErrorTest < ActiveSupport::TestCase
  extend Support::Minitest::AssociationHelper
  extend Support::Minitest::CallbackHelper
  extend Support::Minitest::ValidationHelper

  belongs_to :ldap_synchronization

  # validations: length
  validates_length_of :description, maximum: 65_535
end
