# frozen_string_literal: true

require 'test_helper'

class LdapSyncErrorTest < ActiveSupport::TestCase
  extend Nokul::Support::Minitest::AssociationHelper
  extend Nokul::Support::Minitest::CallbackHelper
  extend Nokul::Support::Minitest::ValidationHelper

  belongs_to :ldap_entity

  # validations: length
  validates_length_of :description, maximum: 65_535
end
